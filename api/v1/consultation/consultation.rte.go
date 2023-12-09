package consultation

import (
	"heathcare/middleware"

	"github.com/casbin/casbin/v2"
	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

func RoutesConsultation(router *gin.RouterGroup, db *gorm.DB, enforcer *casbin.Enforcer) {

	baseInstance := Database{DB: db, Enforcer: enforcer}
	router.POST("/new", middleware.Authorize("consultation", "write", enforcer), baseInstance.NewMedicament)
	router.GET("/user/:id", middleware.Authorize("consultation", "read", enforcer), baseInstance.GetConsultationOfUserID)
	router.GET("/doctor/all/:id", middleware.Authorize("consultation", "read", enforcer), baseInstance.GetConsultationForDoctor)

}
