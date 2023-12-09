package notification

import (
	"heathcare/middleware"

	"github.com/casbin/casbin/v2"
	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

func RoutesNotifications(router *gin.RouterGroup, db *gorm.DB, enforcer *casbin.Enforcer) {

	baseInstance := Database{DB: db, Enforcer: enforcer}
	router.GET("/all", middleware.Authorize("notifications", "read", enforcer), baseInstance.GetAllNotification)
	router.GET("/user/:id", middleware.Authorize("notifications", "read", enforcer), baseInstance.GetNotificationsOfUserID)

}
