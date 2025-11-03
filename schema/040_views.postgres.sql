-- Auto-generated from schema-views-postgres.psd1 (map@9d3471b)
-- engine: postgres
-- table:  login_attempts
-- Contract view for [login_attempts]
-- Exposes hashed identifiers only; adds hex helpers.
CREATE OR REPLACE VIEW vw_login_attempts AS
SELECT
  id,
  ip_hash,
  UPPER(encode(ip_hash,'hex'))::char(32) AS ip_hash_hex,
  attempted_at,
  success,
  user_id,
  username_hash,
  UPPER(encode(username_hash,'hex'))::char(64) AS username_hash_hex,
  auth_event_id
FROM login_attempts;
