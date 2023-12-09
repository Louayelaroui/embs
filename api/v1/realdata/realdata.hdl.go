package realdata

import (
	"heathcare/api/app/user"
	"heathcare/api/v1/notification"
	"heathcare/middleware"
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

// create new real data
func (db Database) NewRealData(ctx *gin.Context) {

	// init vars
	var realdata Realdata
	empty_reg, _ := regexp.Compile(os.Getenv("EMPTY_REGEX"))

	// unmarshal sent json
	if err := ctx.ShouldBindJSON(&realdata); err != nil {
		ctx.JSON(http.StatusBadRequest, gin.H{"message": err.Error()})
		return
	}

	// check fields
	if empty_reg.MatchString(realdata.ActivityLevel) ||
		realdata.HeartRate == 0 ||
		realdata.StepCount == 0 ||
		realdata.CaloriesBurned == 0 ||
		realdata.OxygenLevel == 0 ||
		realdata.StressLevel == 0 ||
		realdata.BloodSugar == 0 {

		ctx.JSON(http.StatusBadRequest, gin.H{"message": "invalid fields"})
		return
	}

	// session informations

	// init new role
	new_realdata := Realdata{
		UserID:         realdata.UserID,
		HeartRate:      realdata.HeartRate,
		StepCount:      realdata.StepCount,
		CaloriesBurned: realdata.CaloriesBurned,
		ActivityLevel:  realdata.ActivityLevel,
		OxygenLevel:    realdata.OxygenLevel,
		StressLevel:    realdata.StressLevel,
		BloodSugar:     realdata.BloodSugar,
	}

	if exists := user.CheckUserExists(db.DB, uint(realdata.UserID)); !exists {
		ctx.JSON(http.StatusBadRequest, gin.H{"message": "invalid user id"})
		return
	}

	// create new role
	if err := NewRealData(db.DB, new_realdata); err != nil {
		ctx.JSON(http.StatusBadRequest, gin.H{"message": err.Error()})
		return
	}

	var notifications notification.Notification
	var problem1 = false
	var problem2 = false
	var problem3 = false
	var problem4 = false
	issue1 := "Noraml"
	issue2 := "Noraml"
	issue3 := "Noraml"
	issue4 := "Noraml"
	if realdata.HeartRate > 100 {
		problem1 = true

		issue1 = "High heart rate:" + strconv.Itoa(realdata.HeartRate)
	}

	if realdata.OxygenLevel < 95.0 {
		problem2 = true

		notifications.OxygenLevel = "Low oxygen level:" + strconv.Itoa(int(realdata.OxygenLevel))
	}

	if realdata.StressLevel > 8 {
		problem3 = true
		notifications.StressLevel = "High stress level: Relax and destress" + strconv.Itoa(int(realdata.StressLevel))
	}

	if realdata.BloodSugar < 70 {
		problem4 = true
		notifications.BloodSugar = "Low blood sugar:" + strconv.Itoa(int(realdata.BloodSugar))
	}

	if problem1 || problem2 || problem3 || problem4 {

		session := middleware.ExtractTokenValues(ctx)

		new_notification := notification.Notification{
			UserID:      session.UserID,
			HeartRate:   issue1,
			OxygenLevel: issue2,
			StressLevel: issue3,
			BloodSugar:  issue4,
			TypeOfIssue: "Bad",
		}

		// create user
		if _, err := notification.NewNotification(db.DB, new_notification); err != nil {
			ctx.JSON(http.StatusBadRequest, gin.H{"message": err.Error()})
			return
		}

		ctx.JSON(http.StatusOK, gin.H{"message": "Detected Notification!"})

	}

	ctx.JSON(http.StatusOK, gin.H{"message": "created"})
}

func (db Database) GetAllRealData(ctx *gin.Context) {

	users, err := GetAllRealData(db.DB)
	if err != nil {
		ctx.JSON(http.StatusBadRequest, gin.H{"message": err.Error()})
		return
	}

	ctx.JSON(http.StatusOK, users)
}

func (db Database) DeleteAllRealData(ctx *gin.Context) {
	err := DeleteAllRealData(db.DB)
	if err != nil {
		ctx.JSON(http.StatusBadRequest, gin.H{"message": err.Error()})
		return
	}

	ctx.JSON(http.StatusOK, gin.H{"message": "All Real Data deleted successfully"})
}

func (db Database) GetRealDataOfUser(ctx *gin.Context) {
	userID, err := strconv.Atoi(ctx.Param("id"))
	if err != nil {
		ctx.JSON(http.StatusBadRequest, gin.H{"message": err.Error()})
		return
	}

	if exists := user.CheckUserExists(db.DB, uint(userID)); !exists {
		ctx.JSON(http.StatusBadRequest, gin.H{"message": "invalid user id affected"})
		return
	}
	med, err := GetRealDataOfUser(db.DB, uint(userID))
	if err != nil {
		ctx.JSON(http.StatusBadRequest, gin.H{"message": err.Error()})
		return
	}

	ctx.JSON(http.StatusOK, med)
}
