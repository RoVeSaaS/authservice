-- name: CreateUser :one
insert into users (
  user_id,
  tenant_id,
  user_name,
  user_email,
  first_name,
  last_name,
  password,
  is_active
) values (
    $1, $2, $3, $4, $5, $6, $7, $8
) RETURNING *;

-- name: GetUsers :many
select * from users
where
tenant_id = sqlc.arg('tenant_id')
order by user_id
LIMIT $1
OFFSET $2;

-- name: GetUserById :one
select * from users
where
tenant_id = sqlc.arg('tenant_id') AND
user_id = $1
LIMIT 1;

-- name: UpdateUserStatus :one
UPDATE users 
SET
is_active = coalesce(sqlc.narg('is_active'), is_active)
WHERE
tenant_id = sqlc.arg('tenant_id') AND
user_id = sqlc.arg('user_id')
RETURNING *;

-- name: AssignUserRole :one
insert into user_roles (
  user_id ,
  role_id ,
  tenant_id
) values (
    $1, $2, $3
) RETURNING *;

-- name: AssignUserGroup :one
insert into user_groups (
  user_id ,
  group_id ,
  tenant_id
) values (
    $1, $2, $3
) RETURNING *;

-- name: AssignGroupRole :one
insert into role_groups (
  group_id ,
  role_id ,
  tenant_id
) values (
    $1, $2, $3
) RETURNING *;