package medicament

import (
	"heathcare/api/app/user"
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

func (db Database) NewMedicament(ctx *gin.Context) {

	// init vars
	var medicament Medicament
	empty_reg, _ := regexp.Compile(os.Getenv("EMPTY_REGEX"))

	// unmarshal sent json
	if err := ctx.ShouldBindJSON(&medicament); err != nil {
		ctx.JSON(http.StatusBadRequest, gin.H{"message": err.Error()})
		return
	}

	// check fields
	if empty_reg.MatchString(medicament.Description) {
		ctx.JSON(http.StatusBadRequest, gin.H{"message": "invalid fields"})
		return
	}

	if exists := user.CheckUserExists(db.DB, medicament.AffectedTo); !exists {
		ctx.JSON(http.StatusBadRequest, gin.H{"message": "invalid user id affected"})
		return
	}

	// init new med
	new_medicament := Medicament{
		Name:         medicament.Name,
		AffectedTo:   medicament.AffectedTo,
		Description:  medicament.Description,
		Manufacturer: medicament.Manufacturer,
		Dosage:       medicament.Dosage,
		Expiration:   medicament.Expiration,
		AffectedAt:   medicament.AffectedAt,
	}

	_, err := NewMedicament(db.DB, new_medicament)
	if err != nil {
		ctx.JSON(http.StatusBadRequest, gin.H{"message": err.Error()})
		return
	}

	ctx.JSON(http.StatusOK, gin.H{"message": "created"})

}

func (db Database) GetMedicamentsAffected(ctx *gin.Context) {
	userID, err := strconv.Atoi(ctx.Param("id"))
	if err != nil {
		ctx.JSON(http.StatusBadRequest, gin.H{"message": err.Error()})
		return
	}

	if exists := user.CheckUserExists(db.DB, uint(userID)); !exists {
		ctx.JSON(http.StatusBadRequest, gin.H{"message": "invalid user id affected"})
		return
	}
	med, err := GetMedicaments(db.DB, uint(userID))
	if err != nil {
		ctx.JSON(http.StatusBadRequest, gin.H{"message": err.Error()})
		return
	}

	ctx.JSON(http.StatusOK, med)
}
