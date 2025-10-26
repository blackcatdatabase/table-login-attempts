-- Auto-generated from schema-views-postgres.psd1 (map@38d5403)
-- engine: postgres
-- table:  login_attempts
-- Contract view for [login_attempts]
-- Exposes hashed identifiers only; adds hex helpers.
CREATE OR REPLACE VIEW vw_login_attempts AS
SELECT
  id,
  ip_hash,
  encode(ip_hash, 'hex') AS ip_hash_hex,
  attempted_at,
  success,
  user_id,
  username_hash,
  encode(username_hash, 'hex') AS username_hash_hex,
  auth_event_id
FROM login_attempts;
