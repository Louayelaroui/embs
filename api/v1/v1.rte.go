package v1

import (
	"heathcare/api/v1/consultation"
	"heathcare/api/v1/medicament"
	"heathcare/api/v1/notification"
	"heathcare/api/v1/realdata"

	"github.com/casbin/casbin/v2"
	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

func RoutesV1(router *gin.RouterGroup, db *gorm.DB, enforcer *casbin.Enforcer) {

	realdata.RealdataRoutes(router.Group("/realdata"), db, enforcer)
	notification.RoutesNotifications(router.Group("/notification"), db, enforcer)
	medicament.UserMedicament(router.Group("/medicament"), db, enforcer)
	consultation.RoutesConsultation(router.Group("/consultation"), db, enforcer)

}
