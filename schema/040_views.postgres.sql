-- Auto-generated from schema-views-postgres.yaml (map@sha1:5C6FE96DC2067A978A357A1DCB8631B46C71D429)
-- engine: postgres
-- table:  login_attempts

-- Contract view for [login_attempts]
-- Exposes hashed identifiers only; adds hex helpers.
CREATE OR REPLACE VIEW vw_login_attempts AS
SELECT
  id,
  ip_hash,
  ip_hash_key_version,
  UPPER(encode(ip_hash,'hex')) AS ip_hash_hex,
  attempted_at,
  success,
  user_id,
  username_hash,
  username_hash_key_version,
  UPPER(encode(username_hash,'hex')) AS username_hash_hex,
  auth_event_id
FROM login_attempts;
