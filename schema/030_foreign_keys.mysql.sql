-- Auto-generated from schema-map-mysql.psd1 (map@mtime:2025-11-27T15:13:14Z)
-- engine: mysql
-- table:  login_attempts

ALTER TABLE login_attempts ADD CONSTRAINT fk_login_attempts_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL;

ALTER TABLE login_attempts ADD CONSTRAINT fk_login_attempts_auth_event FOREIGN KEY (auth_event_id) REFERENCES auth_events(id) ON DELETE SET NULL;
