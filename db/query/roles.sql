-- name: CreateRole :one
INSERT INTO roles (
role_id,
role_name,
tenant_id
) VALUES (
$1, $2, $3
) RETURNING * ;

-- name: GetRoles :many
select * from roles
where
tenant_id = sqlc.arg('tenant_id')
order by role_id
LIMIT $1
OFFSET $2;

-- name: GetRoleById :one
select * from roles
where role_id = $1 LIMIT 1;

-- name: DeleteRoleById :exec
delete from roles 
where role_id = $1;