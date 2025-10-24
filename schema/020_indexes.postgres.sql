-- Auto-generated from schema-map-postgres.psd1 (map@mtime:2025-10-24T09:46:38Z)
-- engine: postgres
-- table:  login_attempts
CREATE INDEX idx_login_ip_success_time ON login_attempts (ip_hash, success, attempted_at);

CREATE INDEX idx_login_attempted_at ON login_attempts (attempted_at);

CREATE INDEX idx_login_username_hash ON login_attempts (username_hash);

CREATE INDEX idx_login_user_time ON login_attempts (user_id, attempted_at);
