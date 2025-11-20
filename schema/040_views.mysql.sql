-- Auto-generated from schema-views-mysql.psd1 (map@62c9c93)
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

-- Auto-generated from schema-views-mysql.psd1 (map@62c9c93)
-- engine: mysql
-- table:  login_attempts_hotspots_user
-- Security: users with failed logins (last 24h)
CREATE OR REPLACE ALGORITHM=MERGE SQL SECURITY INVOKER VIEW vw_login_hotspots_user AS
SELECT
  user_id,
  SUM(CASE WHEN attempted_at > NOW() - INTERVAL 24 HOUR THEN 1 ELSE 0 END)                         AS total_24h,
  SUM(CASE WHEN success = 0 AND attempted_at > NOW() - INTERVAL 24 HOUR THEN 1 ELSE 0 END)         AS failed_24h,
  MAX(attempted_at) AS last_attempt_at
FROM login_attempts
WHERE user_id IS NOT NULL
GROUP BY user_id
HAVING SUM(CASE WHEN success = 0 AND attempted_at > NOW() - INTERVAL 24 HOUR THEN 1 ELSE 0 END) > 0
ORDER BY failed_24h DESC, last_attempt_at DESC;


-- Auto-generated from schema-views-mysql.psd1 (map@62c9c93)
-- engine: mysql
-- table:  login_attempts_hotspots_ip
-- Security: IPs with failed logins (last 24h)
CREATE OR REPLACE ALGORITHM=MERGE SQL SECURITY INVOKER VIEW vw_login_hotspots_ip AS
SELECT
  ip_hash,
  UPPER(HEX(ip_hash)) AS ip_hash_hex,
  SUM(CASE WHEN attempted_at > NOW() - INTERVAL 24 HOUR THEN 1 ELSE 0 END)                             AS total_24h,
  SUM(CASE WHEN success = 0 AND attempted_at > NOW() - INTERVAL 24 HOUR THEN 1 ELSE 0 END)             AS failed_24h,
  MAX(attempted_at) AS last_attempt_at
FROM login_attempts
GROUP BY ip_hash
HAVING SUM(CASE WHEN success = 0 AND attempted_at > NOW() - INTERVAL 24 HOUR THEN 1 ELSE 0 END) > 0
ORDER BY failed_24h DESC, last_attempt_at DESC;

