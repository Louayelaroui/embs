package app

import (
	permission "heathcare/api/app/permission"
	"heathcare/api/app/role"
	"heathcare/api/app/user"

	"github.com/casbin/casbin/v2"
	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

// declare app routes
func RoutesApps(router *gin.RouterGroup, db *gorm.DB, enforcer *casbin.Enforcer) {

	// user routes
	user.UserRoutes(router.Group("/user"), db, enforcer)

	// role routes
	role.RoutesRoles(router.Group("/role"), db, enforcer)

	// permission routes
	permission.RoutesPermissions(router.Group("/permission"), db, enforcer)

}
