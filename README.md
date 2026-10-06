# drp-availability-db

Read-model schema `availability` (occupancy projections). **Migrations only.** Engine: [`drp-infra-postgres`](https://github.com/code-corhuila/drp-infra-postgres). No database container here. `drp-availability-api` must not own DDL.

Catalog stays in `drp-space-db`. CONFIRMED overlap stays in `drp-reservation-db`. `models.md` has no SQL for this schema; occupancy is the conservative projection named in `01-context/project-profile.md`.

## Layout (Anexo J)

| Folder | Content |
|--------|---------|
| `01_ddl/` | `occupancy` (schema-qualified) |
| `02_dml/` | no Corte 2 seed (API projects from HTTP) |
| `03_dcl/` | grants for `availability_app` (no DELETE; retire via `deleted_at`) |
| `04_tcl/` | reserved |
| `05_rollbacks/` | local undo |
| `deploy/compose.yml` | Flyway job only |

Control table: `availability.flyway_availability_history`.

## Run

```bash
# infra first
docker compose --env-file env/dev.env -f deploy/compose.yml up -d

# this repo
docker compose --env-file .env.example -f deploy/compose.yml run --rm availability-migrate
```

Corte 2 UI (`drp-front`) does **not** need this migrate: it uses synthetic contract data.

## Branching

Child of `develop` named `feat/…`. Never commit on `develop` / `qa` / `main`. Promote with `cherry-pick -x`.
