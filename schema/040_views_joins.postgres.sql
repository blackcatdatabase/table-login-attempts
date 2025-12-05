-- Auto-generated from joins-postgres.yaml (map@85230ed)
-- engine: postgres
-- view:   login_attempts_hotspots_ip

-- Security: IPs with failed logins (last 24h)
CREATE OR REPLACE VIEW vw_login_hotspots_ip AS
SELECT
  ip_hash,
  UPPER(encode(ip_hash,$$hex$$)) AS ip_hash_hex,
  COUNT(*) FILTER (WHERE attempted_at > now() - interval $$24 hours$$) AS total_24h,
  COUNT(*) FILTER (WHERE success = false AND attempted_at > now() - interval $$24 hours$$) AS failed_24h,
  MAX(attempted_at) AS last_attempt_at
FROM login_attempts
GROUP BY ip_hash
HAVING COUNT(*) FILTER (WHERE success = false AND attempted_at > now() - interval $$24 hours$$) > 0
ORDER BY failed_24h DESC, last_attempt_at DESC;

-- Auto-generated from joins-postgres.yaml (map@85230ed)
-- engine: postgres
-- view:   login_attempts_activity

-- Per-user recent login activity
CREATE OR REPLACE VIEW vw_login_attempts_activity AS
SELECT
  u.id AS user_id,
  MAX(l.attempted_at) AS last_attempt_at,
  COUNT(*) FILTER (WHERE l.attempted_at > now() - interval $$24 hours$$) AS attempts_24h,
  COUNT(*) FILTER (WHERE l.success = false AND l.attempted_at > now() - interval $$24 hours$$) AS failed_24h
FROM users u
LEFT JOIN login_attempts l ON l.user_id = u.id
GROUP BY u.id;


-- Auto-generated from joins-postgres.yaml (map@85230ed)
-- engine: postgres
-- view:   login_attempts_hotspots_user

-- Security: users with failed logins (last 24h)
CREATE OR REPLACE VIEW vw_login_hotspots_user AS
SELECT
  user_id,
  COUNT(*) FILTER (WHERE attempted_at > now() - interval $$24 hours$$) AS total_24h,
  COUNT(*) FILTER (WHERE success = false AND attempted_at > now() - interval $$24 hours$$) AS failed_24h,
  MAX(attempted_at) AS last_attempt_at
FROM login_attempts
WHERE user_id IS NOT NULL
GROUP BY user_id
HAVING COUNT(*) FILTER (WHERE success = false AND attempted_at > now() - interval $$24 hours$$) > 0
ORDER BY failed_24h DESC, last_attempt_at DESC;

