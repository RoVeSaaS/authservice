-- name: CreateTenant :one
INSERT INTO tenants (
  tenant_id,
  tenant_name,
  tenant_owner,
  is_active,
  tenant_city,
  tenant_state,
  tenant_country
)
VALUES (
    $1,$2,$3,$4,$5,$6,$7
) RETURNING * ;


-- name: GetTenants :many
select * from tenants
order by tenant_id
LIMIT $1
OFFSET $2;

-- name: GetTenantById :one
select * from tenants
where tenant_id = $1 LIMIT 1;

-- name: DeleteTenantById :exec
delete from tenants 
where tenant_id = $1;

-- name: UpdateTenantStatus :one
UPDATE tenants 
SET
is_active = coalesce(sqlc.narg('is_active'), is_active)
WHERE
tenant_id = sqlc.arg('tenant_id')
RETURNING *;