-- Auto-generated from schema-map-postgres.yaml (map@sha1:F0EE237771FBA8DD7C4E886FF276F91A862C3718)
-- engine: postgres
-- table:  login_attempts

CREATE INDEX IF NOT EXISTS idx_login_ip_success_time ON login_attempts (ip_hash, success, attempted_at);

CREATE INDEX IF NOT EXISTS idx_login_attempted_at ON login_attempts (attempted_at);

CREATE INDEX IF NOT EXISTS idx_login_username_hash ON login_attempts (username_hash);

CREATE INDEX IF NOT EXISTS idx_login_auth_event ON login_attempts (auth_event_id);

CREATE INDEX IF NOT EXISTS idx_login_user_time ON login_attempts (user_id, attempted_at);
