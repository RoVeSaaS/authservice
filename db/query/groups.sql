-- name: CreateGroup :one
INSERT INTO groups (
group_id,
group_name,
tenant_id
) VALUES (
$1, $2, $3
) RETURNING * ;

-- name: GetGroups :many
select * from groups
where
tenant_id = sqlc.arg('tenant_id')
order by group_id
LIMIT $1
OFFSET $2;

-- name: GetGroupById :one
select * from groups
where group_id = $1 LIMIT 1;

-- name: DeleteGroupById :exec
delete from groups 
where group_id = $1;