-- Auto-generated from schema-views-mysql.psd1 (map@38d5403)
-- engine: mysql
-- table:  login_attempts
-- Contract view for [login_attempts]
-- Exposes hashed identifiers; adds HEX helpers.
CREATE OR REPLACE SQL SECURITY INVOKER VIEW vw_login_attempts AS
SELECT
  id,
  ip_hash,
  HEX(ip_hash) AS ip_hash_hex,
  attempted_at,
  success,
  user_id,
  username_hash,
  HEX(username_hash) AS username_hash_hex,
  auth_event_id
FROM login_attempts;
