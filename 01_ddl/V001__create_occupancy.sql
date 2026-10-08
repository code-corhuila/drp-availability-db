-- Schema `availability` already exists in drp-infra-postgres. Do not CREATE EXTENSION.
-- Qualify the schema so Flyway cannot land tables elsewhere.
-- Read model only. Catalog SoT is space; CONFIRMED overlap SoT is reservation.
-- space_id is a reference, not a cross-domain FK (Anexo J).

CREATE TABLE availability.occupancy (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  space_id    UUID NOT NULL,
  start_at    TIMESTAMPTZ NOT NULL,
  end_at      TIMESTAMPTZ NOT NULL,
  source_kind VARCHAR(32) NOT NULL CHECK (source_kind IN ('BLOCK', 'CONFIRMED')),
  source_id   UUID,
  created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  deleted_at  TIMESTAMPTZ,
  CHECK (end_at > start_at)
);

CREATE INDEX idx_occupancy_space_range
  ON availability.occupancy (space_id, start_at, end_at);

CREATE UNIQUE INDEX ux_occupancy_source
  ON availability.occupancy (source_kind, source_id)
  WHERE source_id IS NOT NULL AND deleted_at IS NULL;
