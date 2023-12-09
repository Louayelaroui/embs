package consultation

import (
	"heathcare/api/app/user"
	"net/http"
	"os"
	"regexp"
	"strconv"

	"github.com/casbin/casbin/v2"
	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

type Database struct {
	DB       *gorm.DB
	Enforcer *casbin.Enforcer
}

func (db Database) NewMedicament(ctx *gin.Context) {

	// init vars
	var consultation Consultation
	empty_reg, _ := regexp.Compile(os.Getenv("EMPTY_REGEX"))

	// unmarshal sent json
	if err := ctx.ShouldBindJSON(&consultation); err != nil {
		ctx.JSON(http.StatusBadRequest, gin.H{"message": err.Error()})
		return
	}

	// check fields
	if empty_reg.MatchString(consultation.Comment) {
		ctx.JSON(http.StatusBadRequest, gin.H{"message": "invalid fields"})
		return
	}

	if exists := user.CheckUserExists(db.DB, consultation.AffectedTo); !exists {
		ctx.JSON(http.StatusBadRequest, gin.H{"message": "invalid user id affected"})
		return
	}

	if exists := user.CheckUserExists(db.DB, consultation.DoctorID); !exists {
		ctx.JSON(http.StatusBadRequest, gin.H{"message": "invalid user id affected"})
		return
	}
	// init new med
	new_medicament := Consultation{
		AffectedTo: consultation.AffectedTo,
		DoctorID:   consultation.DoctorID,
		Comment:    consultation.Comment,
	}

	_, err := NewConsultation(db.DB, new_medicament)
	if err != nil {
		ctx.JSON(http.StatusBadRequest, gin.H{"message": err.Error()})
		return
	}

	ctx.JSON(http.StatusOK, gin.H{"message": "created"})

}

func (db Database) GetConsultationOfUserID(ctx *gin.Context) {

	userID, err := strconv.Atoi(ctx.Param("id"))
	if err != nil {
		ctx.JSON(http.StatusBadRequest, gin.H{"message": err.Error()})
		return
	}

	// check user exists
	if exists := user.CheckUserExists(db.DB, uint(userID)); !exists {
		ctx.JSON(http.StatusBadRequest, gin.H{"message": "invalid user id"})
		return
	}

	var notification Consultation
	err = GetConsultationOfUserID(db.DB, &notification, uint(userID))
	if err != nil {
		ctx.JSON(http.StatusBadRequest, gin.H{"message": err.Error()})
		return
	}

	ctx.JSON(http.StatusOK, notification)
}

func (db Database) GetConsultationForDoctor(ctx *gin.Context) {

	userID, err := strconv.Atoi(ctx.Param("id"))
	if err != nil {
		ctx.JSON(http.StatusBadRequest, gin.H{"message": err.Error()})
		return
	}

	// check user exists
	if exists := user.CheckUserExists(db.DB, uint(userID)); !exists {
		ctx.JSON(http.StatusBadRequest, gin.H{"message": "invalid user id"})
		return
	}

	var notification Consultation
	err = GetConsultationForDoctor(db.DB, &notification, uint(userID))
	if err != nil {
		ctx.JSON(http.StatusBadRequest, gin.H{"message": err.Error()})
		return
	}

	ctx.JSON(http.StatusOK, notification)
}
