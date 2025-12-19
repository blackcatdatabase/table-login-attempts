-- Auto-generated from core/joins-mysql.yaml (map@sha1:DA70105A5B799F72A56FEAB71A5171F946A770D2)
-- engine: mysql
-- view:   login_attempts_activity

CREATE OR REPLACE ALGORITHM=TEMPTABLE SQL SECURITY INVOKER VIEW vw_login_attempts_activity AS
SELECT
  u.id AS user_id,
  MAX(l.attempted_at) AS last_attempt_at,
  SUM(CASE WHEN l.attempted_at > NOW() - INTERVAL 24 HOUR THEN 1 ELSE 0 END) AS attempts_24h,
  SUM(CASE WHEN l.success = 0 AND l.attempted_at > NOW() - INTERVAL 24 HOUR THEN 1 ELSE 0 END) AS failed_24h
FROM users u
LEFT JOIN login_attempts l ON l.user_id = u.id
GROUP BY u.id;

-- Auto-generated from core/joins-mysql.yaml (map@sha1:DA70105A5B799F72A56FEAB71A5171F946A770D2)
-- engine: mysql
-- view:   login_attempts_activity

CREATE OR REPLACE ALGORITHM=TEMPTABLE SQL SECURITY INVOKER VIEW vw_login_attempts_activity AS
SELECT
  u.id AS user_id,
  MAX(l.attempted_at) AS last_attempt_at,
  SUM(CASE WHEN l.attempted_at > NOW() - INTERVAL 24 HOUR THEN 1 ELSE 0 END) AS attempts_24h,
  SUM(CASE WHEN l.success = 0 AND l.attempted_at > NOW() - INTERVAL 24 HOUR THEN 1 ELSE 0 END) AS failed_24h
FROM users u
LEFT JOIN login_attempts l ON l.user_id = u.id
GROUP BY u.id;

-- Auto-generated from joins-mysql.yaml (map@sha1:DA70105A5B799F72A56FEAB71A5171F946A770D2)
-- engine: mysql
-- view:   login_hotspots_ip

CREATE OR REPLACE ALGORITHM=TEMPTABLE SQL SECURITY INVOKER VIEW vw_login_hotspots_ip AS
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


-- Auto-generated from core/joins-mysql.yaml (map@sha1:DA70105A5B799F72A56FEAB71A5171F946A770D2)
-- engine: mysql
-- view:   login_hotspots_user

CREATE OR REPLACE ALGORITHM=TEMPTABLE SQL SECURITY INVOKER VIEW vw_login_hotspots_user AS
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

