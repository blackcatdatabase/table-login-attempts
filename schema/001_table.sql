-- Auto-generated from schema-map.psd1 (map@6cefe8e)
-- table: login_attempts
CREATE TABLE IF NOT EXISTS login_attempts (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  ip_hash BINARY(32) NOT NULL,
  attempted_at DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  success BOOLEAN NOT NULL DEFAULT 0,
  user_id BIGINT UNSIGNED NULL,
  username_hash BINARY(32) NULL,
  auth_event_id BIGINT UNSIGNED NULL,
  INDEX idx_login_ip_success_time (ip_hash, success, attempted_at),
  INDEX idx_login_attempted_at (attempted_at),
  INDEX idx_login_username_hash (username_hash),
  INDEX idx_login_user_time (user_id, attempted_at),
  CONSTRAINT chk_login_success CHECK (success IN (0,1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
