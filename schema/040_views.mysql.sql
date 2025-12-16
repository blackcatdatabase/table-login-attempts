-- Auto-generated from schema-views-mysql.yaml (map@sha1:FFA9A9D6FA9EE079B0DAEBB6FEE023C138E8FFA1)
-- engine: mysql
-- table:  login_attempts

-- Contract view for [login_attempts]
-- Exposes hashed identifiers; adds HEX helpers.
CREATE OR REPLACE ALGORITHM=MERGE SQL SECURITY INVOKER VIEW vw_login_attempts AS
SELECT
  id,
  ip_hash,
  CAST(LPAD(HEX(ip_hash), 64, '0')  AS CHAR(64)) AS ip_hash_hex,
  attempted_at,
  success,
  user_id,
  username_hash,
  CAST(LPAD(HEX(username_hash), 64, '0') AS CHAR(64)) AS username_hash_hex,
  auth_event_id
FROM login_attempts;
