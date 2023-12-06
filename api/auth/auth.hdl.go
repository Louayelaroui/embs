package app_auth

import (
	user "heathcare/api/app/user"
	"heathcare/middleware"
	"net/http"
	"os"
	"regexp"
	"strconv"
	"time"

	"github.com/casbin/casbin/v2"
	"github.com/gin-gonic/gin"
	"golang.org/x/oauth2"
	"golang.org/x/oauth2/google"
	"gorm.io/gorm"
)

type Database struct {
	DB       *gorm.DB
	Enforcer *casbin.Enforcer
}

// signup user
func (db Database) SignUpUser(ctx *gin.Context) {

	// init vars
	var account InsertUser
	empty_reg, _ := regexp.Compile(os.Getenv("EMPTY_REGEX"))

	// upmarshal sent json
	if err := ctx.ShouldBindJSON(&account); err != nil {
		ctx.JSON(http.StatusBadRequest, gin.H{"message": err.Error()})
		return
	}

	// check field validity
	if empty_reg.MatchString(account.Name) || empty_reg.MatchString(account.Email) || empty_reg.MatchString(account.Password) {
		ctx.JSON(http.StatusBadRequest, gin.H{"message": "please complete all fields"})
		return
	}

	// hash password
	user.HashPassword(&account.Password)

	// create new user
	new_user := user.User{
		Name:     account.Name,
		Email:    account.Email,
		Password: account.Password,
		Role:     "user",
	}

	// create user
	saved_user, err := user.NewUser(db.DB, new_user)
	if err != nil {
		ctx.JSON(http.StatusBadRequest, gin.H{"message": err.Error()})
		return
	}

	// super add will add role
	db.Enforcer.AddGroupingPolicy(strconv.FormatUint(uint64(saved_user.ID), 10), saved_user.Role)

	ctx.JSON(http.StatusOK, gin.H{"message": "created"})
}

// signin user
func (db Database) SignInUser(ctx *gin.Context) {

	// init cars
	var user_login UserLogIn
	empty_reg, _ := regexp.Compile(os.Getenv("EMPTY_REGEX"))

	// unmarshal sent json
	if err := ctx.ShouldBindJSON(&user_login); err != nil {
		ctx.JSON(http.StatusBadRequest, gin.H{"message": err.Error()})
	}

	// check field validity
	if empty_reg.MatchString(user_login.Email) || empty_reg.MatchString(user_login.Password) {
		ctx.JSON(http.StatusBadRequest, gin.H{"message": "please complete all fields"})
		return
	}

	// check if email exists
	dbUser, err := user.GetUserByEmail(db.DB, user_login.Email)
	if err != nil {
		ctx.JSON(http.StatusBadRequest, gin.H{"message": "no Such User Found"})
		return
	}

	// update last login
	dbUser.LastLogin = time.Now()

	// update user
	if err := user.UpdateUser(db.DB, dbUser); err != nil {
		ctx.JSON(http.StatusBadRequest, gin.H{"message": err.Error()})
		return
	}

	// compare password
	if isTrue := user.ComparePassword(dbUser.Password, user_login.Password); isTrue {

		// generate token
		token := middleware.GenerateToken(dbUser.ID, dbUser.Role)
		ctx.JSON(http.StatusOK, UserLogedIn{Token: token})
		return
	}

	ctx.JSON(http.StatusBadRequest, gin.H{"message": "password not matched"})
}

// Google AuthO2

var (
	clientID     = "688323724390-5h2b2q0ptv7mlqp89178al1b0l91pi8b.apps.googleusercontent.com"
	clientSecret = "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"
	redirectURL  = "http://localhost:8080/api/auth/callback"
	scopes       = []string{"https://www.googleapis.com/auth/userinfo.email", "https://www.googleapis.com/auth/userinfo.profile"}

	oauth2Config = oauth2.Config{
		ClientID:     clientID,
		ClientSecret: clientSecret,
		RedirectURL:  redirectURL,
		Scopes:       scopes,
		Endpoint:     google.Endpoint,
	}
)
