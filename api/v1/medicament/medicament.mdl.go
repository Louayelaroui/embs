package medicament

import (
	"time"

	"gorm.io/gorm"
)

type Medicament struct {
	ID           uint      `gorm:"column:id;autoIncrement;primaryKey" json:"id"`
	AffectedTo   uint      `gorm:"column:affected_to" json:"affected_to"`
	Name         string    `gorm:"column:name" json:"name"`
	Description  string    `gorm:"column:description" json:"description"`
	Manufacturer string    `gorm:"column:manufacturer" json:"manufacturer"`
	Dosage       string    `gorm:"column:dosage" json:"dosage"`
	Expiration   string    `gorm:"column:expiration" json:"expiration"`
	AffectedAt   time.Time `gorm:"column:affected_at" json:"affected_at"`
	gorm.Model
}

func NewMedicament(db *gorm.DB, medicament Medicament) (Medicament, error) {
	return medicament, db.Create(&medicament).Error
}

func GetMedicaments(db *gorm.DB, affectedTo uint) (medicaments []Medicament, err error) {
	return medicaments, db.Where("affected_to = ?", affectedTo).Find(&medicaments).Error
}

// check if medicament exists
func CheckMedicamentExists(db *gorm.DB, id uint) bool {

	// init vars
	medicament := &Medicament{}

	// check if row exists
	check := db.Where("id=?", id).First(&medicament)
	if check.Error != nil {
		return false
	}

	if check.RowsAffected == 0 {
		return false
	} else {
		return true
	}
}

func SearchMedicaments(db *gorm.DB, medicament Medicament) (medicaments []Medicament, err error) {
	return medicaments, db.Where(&medicament).Find(&medicaments).Error
}

func UpdateMedicament(db *gorm.DB, medicament Medicament) error {
	return db.Where("id=?", medicament.ID).Updates(&medicament).Error
}

func DeleteMedicament(db *gorm.DB, medicament_id uint) error {
	return db.Where("id=?", medicament_id).Delete(&Medicament{}).Error
}
