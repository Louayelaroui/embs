package app_auth

import "time"

type InsertUser struct {
	Name                string    `gorm:"column:name;not null" json:"name"`
	Email               string    `gorm:"column:email;not null;unique" json:"email"`
	Password            string    `gorm:"column:password;not null" json:"password"`
	Weight              float32   `gorm:"column:weight;not null" json:"weight"`
	Height              float32   `gorm:"column:height;not null" json:"height"`
	Cin                 string    `gorm:"column:cin;not null" json:"cin"`
	Telephone           string    `gorm:"column:telephone;not null" json:"telephone"`
	SpecialRequirements string    `gorm:"column:special_requirements;not null" json:"special_requirements"`
	Role                string    `gorm:"column:role;not null" json:"role"`
	LastLogin           time.Time `gorm:"column:last_login" json:"last_login"`
}

type UserLogIn struct {
	Email    string `json:"email"`
	Password string `json:"password"`
}

type UserLogedIn struct {
	Token string `json:"token"`
}
