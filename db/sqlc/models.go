// Code generated by sqlc. DO NOT EDIT.
// versions:
//   sqlc v1.26.0

package db

import (
	"database/sql"

	"github.com/google/uuid"
)

type Group struct {
	GroupID   uuid.UUID      `json:"group_id"`
	GroupName sql.NullString `json:"group_name"`
	TenantID  sql.NullString `json:"tenant_id"`
}

type Role struct {
	RoleID   uuid.UUID      `json:"role_id"`
	RoleName sql.NullString `json:"role_name"`
	TenantID sql.NullString `json:"tenant_id"`
}

type RoleGroup struct {
	RoleID   uuid.NullUUID `json:"role_id"`
	GroupID  uuid.NullUUID `json:"group_id"`
	TenantID uuid.NullUUID `json:"tenant_id"`
}

type Tenant struct {
	TenantID      uuid.UUID      `json:"tenant_id"`
	TenantName    sql.NullString `json:"tenant_name"`
	TenantOwner   sql.NullString `json:"tenant_owner"`
	IsActive      sql.NullBool   `json:"is_active"`
	TenantCity    sql.NullString `json:"tenant_city"`
	TenantState   sql.NullString `json:"tenant_state"`
	TenantCountry sql.NullString `json:"tenant_country"`
}

type User struct {
	UserID    uuid.UUID      `json:"user_id"`
	TenantID  string         `json:"tenant_id"`
	UserName  sql.NullString `json:"user_name"`
	UserEmail sql.NullString `json:"user_email"`
	FirstName sql.NullString `json:"first_name"`
	LastName  sql.NullString `json:"last_name"`
	Password  sql.NullString `json:"password"`
	IsActive  sql.NullBool   `json:"is_active"`
}

type UserGroup struct {
	UserID   uuid.NullUUID `json:"user_id"`
	GroupID  uuid.NullUUID `json:"group_id"`
	TenantID uuid.NullUUID `json:"tenant_id"`
}

type UserRole struct {
	UserID   uuid.NullUUID `json:"user_id"`
	RoleID   uuid.NullUUID `json:"role_id"`
	TenantID uuid.NullUUID `json:"tenant_id"`
}
