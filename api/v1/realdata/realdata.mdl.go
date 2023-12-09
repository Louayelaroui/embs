package realdata

import (
	"gorm.io/gorm"
)

type Realdata struct {
	ID             uint    `gorm:"column:id;autoIncrement;primaryKey" json:"id"`
	HeartRate      int     `gorm:"column:heart_rate" json:"heart_rate"`
	StepCount      int     `gorm:"column:step_count" json:"step_count"`
	CaloriesBurned int     `gorm:"column:calories_burned" json:"calories_burned"`
	ActivityLevel  string  `gorm:"column:activity_level" json:"activity_level"`
	OxygenLevel    float64 `gorm:"column:oxygen_level" json:"oxygen_level"`
	StressLevel    int     `gorm:"column:stress_level" json:"stress_level"`
	BloodSugar     float64 `gorm:"column:blood_sugar" json:"blood_sugar"`

	gorm.Model
}

func NewRealData(db *gorm.DB, realdata Realdata) error {
	return db.Create(&realdata).Error
}

func GetAllRealData(db *gorm.DB) (realdata []Realdata, err error) {
	return realdata, db.Find(&realdata).Error
}

func UpdateRealData(db *gorm.DB, realdata Realdata) error {
	return db.Where("id=?", realdata.ID).Updates(&realdata).Error
}

func DeleteAllRealData(db *gorm.DB) error {
	return db.Session(&gorm.Session{AllowGlobalUpdate: true}).Delete(&Realdata{}).Error
}
