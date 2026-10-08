-- availability_app already has USAGE, CREATE on schema availability (infra init).
-- Tables created by Flyway are owned by availability_app.

GRANT SELECT, INSERT, UPDATE ON ALL TABLES IN SCHEMA availability TO availability_app;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA availability TO availability_app;
-- No DELETE: occupancy.deleted_at is the projection retire path.
