package realdata

import (
	"heathcare/middleware"

	"github.com/casbin/casbin/v2"
	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

func RealdataRoutes(router *gin.RouterGroup, db *gorm.DB, enforcer *casbin.Enforcer) {

	baseInstance := Database{DB: db}
	router.GET("/all", middleware.Authorize("realdata", "read", enforcer), baseInstance.GetAllRealData)
	router.GET("/:id", middleware.Authorize("realdata", "read", enforcer), baseInstance.GetRealDataOfUser)
	router.POST("/new", middleware.Authorize("realdata", "write", enforcer), baseInstance.NewRealData)
	router.DELETE("/deleteall", middleware.Authorize("realdata", "write", enforcer), baseInstance.DeleteAllRealData)
}


