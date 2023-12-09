package consultation

import (
	"time"

	"gorm.io/gorm"
)

type Consultation struct {
	ID         uint      `gorm:"column:id;autoIncrement;primaryKey" json:"id"`
	AffectedTo uint      `gorm:"column:affected_to" json:"affected_to"`
	DoctorID   uint      `gorm:"column:doctor_id" json:"doctor_id"`
	DateTime   time.Time `gorm:"column:date_time" json:"date_time"`
	Comment    string    `gorm:"column:comment" json:"comment"`
}

func NewConsultation(db *gorm.DB, consultation Consultation) (Consultation, error) {
	return consultation, db.Create(&consultation).Error
}

func GetConsultationOfUserID(db *gorm.DB, notification *Consultation, userID uint) error {
	return db.Where("affected_to=?", userID).First(notification).Error
}

func GetConsultationForDoctor(db *gorm.DB, notification *Consultation, userID uint) error {
	return db.Where("doctor_id=?", userID).First(notification).Error
}
