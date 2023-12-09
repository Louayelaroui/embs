package notification

import (
	"heathcare/api/app/user"
	"net/http"
	"strconv"

	"github.com/casbin/casbin/v2"
	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

type Database struct {
	DB       *gorm.DB
	Enforcer *casbin.Enforcer
}

func (db Database) GetNotificationsOfUserID(ctx *gin.Context) {

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

	var notification Notification
	err = GetNotificationsOfUserID(db.DB, &notification, uint(userID))
	if err != nil {
		ctx.JSON(http.StatusBadRequest, gin.H{"message": err.Error()})
		return
	}

	ctx.JSON(http.StatusOK, notification)
}

func (db Database) GetAllNotification(ctx *gin.Context) {

	notifications, err := GetNotifications(db.DB)
	if err != nil {
		ctx.JSON(http.StatusBadRequest, gin.H{"message": err.Error()})
		return
	}

	ctx.JSON(http.StatusOK, notifications)
}
