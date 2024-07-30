package models

type Users struct {
	TenantId  string `json:"tenant_id" binding:"required"`
	UserName  string `json:"user_name"`
	UserEmail string `json:"user_email" binding:"required"`
	FirstName string `json:"first_name"`
	LastName  string `json:"last_name"`
	Password  string `json:"password"`
	IsActive  *bool  `json:"is_active" binding:"required"`
}
