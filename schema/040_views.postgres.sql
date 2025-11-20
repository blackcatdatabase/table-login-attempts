-- Auto-generated from schema-views-postgres.psd1 (map@62c9c93)
-- engine: postgres
-- table:  login_attempts
-- Contract view for [login_attempts]
-- Exposes hashed identifiers only; adds hex helpers.
CREATE OR REPLACE VIEW vw_login_attempts AS
SELECT
  id,
  ip_hash,
  UPPER(encode(ip_hash,'hex')) AS ip_hash_hex,
  attempted_at,
  success,
  user_id,
  username_hash,
  UPPER(encode(username_hash,'hex')) AS username_hash_hex,
  auth_event_id
FROM login_attempts;

-- Auto-generated from schema-views-postgres.psd1 (map@62c9c93)
-- engine: postgres
-- table:  login_attempts_hotspots_user
-- Security: users with failed logins (last 24h)
CREATE OR REPLACE VIEW vw_login_hotspots_user AS
SELECT
  user_id,
  COUNT(*) FILTER (WHERE attempted_at > now() - interval ''24 hours'')                         AS total_24h,
  COUNT(*) FILTER (WHERE success = false AND attempted_at > now() - interval ''24 hours'')     AS failed_24h,
  MAX(attempted_at) AS last_attempt_at
FROM login_attempts
WHERE user_id IS NOT NULL
GROUP BY user_id
HAVING COUNT(*) FILTER (WHERE success = false AND attempted_at > now() - interval ''24 hours'') > 0
ORDER BY failed_24h DESC, last_attempt_at DESC;


-- Auto-generated from schema-views-postgres.psd1 (map@62c9c93)
-- engine: postgres
-- table:  login_attempts_hotspots_ip
-- Security: IPs with failed logins (last 24h)
CREATE OR REPLACE VIEW vw_login_hotspots_ip AS
SELECT
  ip_hash,
  UPPER(encode(ip_hash,''hex'')) AS ip_hash_hex,
  COUNT(*) FILTER (WHERE attempted_at > now() - interval ''24 hours'')                         AS total_24h,
  COUNT(*) FILTER (WHERE success = false AND attempted_at > now() - interval ''24 hours'')     AS failed_24h,
  MAX(attempted_at) AS last_attempt_at
FROM login_attempts
GROUP BY ip_hash
HAVING COUNT(*) FILTER (WHERE success = false AND attempted_at > now() - interval ''24 hours'') > 0
ORDER BY failed_24h DESC, last_attempt_at DESC;

