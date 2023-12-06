package user

import (
	"time"

	"golang.org/x/crypto/bcrypt"
	"gorm.io/gorm"
)

type User struct {
	ID        uint      `gorm:"column:id;autoIncrement;primaryKey" json:"id"`
	Name      string    `gorm:"column:name;not null" json:"name"`
	Email     string    `gorm:"column:email;not null;unique" json:"email"`
	Password  string    `gorm:"column:password;not null" json:"password"`
	Role      string    `gorm:"column:role;not null" json:"role"`
	LastLogin time.Time `gorm:"column:last_login" json:"last_login"`
	CreatedBy uint      `gorm:"column:created_by" json:"created_by"`
	// Forigen Key List
	gorm.Model
}

// hash password
func HashPassword(pass *string) {
	bytePass := []byte(*pass)
	hPass, _ := bcrypt.GenerateFromPassword(bytePass, bcrypt.DefaultCost)
	*pass = string(hPass)
}

// create new user
func NewUser(db *gorm.DB, user User) (User, error) {
	return user, db.Create(&user).Error
}

// get all users
func GetUsers(db *gorm.DB) (users []User, err error) {
	return users, db.Find(&users).Error
}

// check if user exists
func CheckUserExists(db *gorm.DB, id uint) bool {

	// init vars
	user := &User{}

	// check if row exists
	check := db.Where("id=?", id).First(&user)
	if check.Error != nil {
		return false
	}

	if check.RowsAffected == 0 {
		return false
	} else {
		return true
	}
}

// search users
func SearchUsers(db *gorm.DB, user User) (users []User, err error) {
	return users, db.Where(&user).Find(&users).Error
}

// update user
func UpdateUser(db *gorm.DB, user User) error {
	return db.Where("id=?", user.ID).Updates(&user).Error
}

// delete user
func DeleteUser(db *gorm.DB, user_id uint) error {
	return db.Where("id=?", user_id).Delete(&User{}).Error
}

// get user by email
func GetUserByEmail(db *gorm.DB, email string) (user User, err error) {
	return user, db.First(&user, "email=?", email).Error
}

// compare two passwords
func ComparePassword(dbPass, pass string) bool {
	return bcrypt.CompareHashAndPassword([]byte(dbPass), []byte(pass)) == nil
}
