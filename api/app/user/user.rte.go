package user

import (
	"heathcare/middleware"

	"github.com/casbin/casbin/v2"
	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

func UserRoutes(router *gin.RouterGroup, db *gorm.DB, enforcer *casbin.Enforcer) {

	baseInstance := Database{DB: db, Enforcer: enforcer}

	router.POST("/new", middleware.Authorize("users", "write", enforcer), baseInstance.NewUser)
	router.GET("/all", middleware.Authorize("users", "read", enforcer), baseInstance.GetUsers)
	router.POST("/search", middleware.Authorize("users", "read", enforcer), baseInstance.SearchUsers)
	router.PUT("/:id", middleware.Authorize("users", "write", enforcer), baseInstance.UpdateUser)
	router.DELETE("/:id", middleware.Authorize("users", "write", enforcer), baseInstance.DeleteUser)
}
