-- Auto-generated from schema-views-mysql.psd1 (map@mtime:2025-10-24T09:19:46Z)
-- engine: mysql
-- table:  login_attempts
-- Contract view for [login_attempts]
-- Exposes hashed identifiers only; safe for security dashboards.
CREATE OR REPLACE VIEW vw_login_attempts AS
SELECT
  id,
  ip_hash,
  attempted_at,
  success,
  user_id,
  username_hash,
  auth_event_id
FROM login_attempts;
