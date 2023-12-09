package medicament

import (
	"heathcare/middleware"

	"github.com/casbin/casbin/v2"
	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

func UserMedicament(router *gin.RouterGroup, db *gorm.DB, enforcer *casbin.Enforcer) {

	baseInstance := Database{DB: db, Enforcer: enforcer}

	router.POST("/new", middleware.Authorize("medicament", "write", enforcer), baseInstance.NewMedicament)
	router.GET("/:id", middleware.Authorize("medicament", "read", enforcer), baseInstance.GetMedicamentsAffected)

}
