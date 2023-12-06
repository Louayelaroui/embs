package v1

import (
	"github.com/casbin/casbin/v2"
	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

func RoutesV1(router *gin.RouterGroup, db *gorm.DB, enforcer *casbin.Enforcer) {

	// your project routes here...
}
