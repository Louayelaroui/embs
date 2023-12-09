package notification

import "gorm.io/gorm"

type Notification struct {
	ID          uint   `gorm:"column:id;autoIncrement;primaryKey" json:"id"`
	UserID      uint   `gorm:"column:user_id" json:"user_id"`
	DoctorID    uint   `gorm:"column:doctor_id" json:"doctor_id"`
	HeartRate   string `gorm:"column:heart_rate" json:"heart_rate"`
	OxygenLevel string `gorm:"column:oxygen_level" json:"oxygen_level"`
	StressLevel string `gorm:"column:stress_level" json:"stress_level"`
	BloodSugar  string `gorm:"column:blood_sugar" json:"blood_sugar"`
	TypeOfIssue string `gorm:"column:type_of_issue" json:"type_of_issue"`
	gorm.Model
}

func NewNotification(db *gorm.DB, notification Notification) (Notification, error) {
	return notification, db.Create(&notification).Error
}

func GetNotificationsOfUserID(db *gorm.DB, notification *Notification, userID uint) error {
	return db.Where("user_id=?", userID).First(notification).Error
}

func GetNotifications(db *gorm.DB) (notification []Notification, err error) {
	return notification, db.Find(&notification).Error
}
