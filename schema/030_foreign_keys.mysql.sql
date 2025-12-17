-- Auto-generated from schema-map-mysql.yaml (map@sha1:7AAC4013A2623AC60C658C9BF8458EFE0C7AB741)
-- engine: mysql
-- table:  login_attempts

ALTER TABLE login_attempts ADD CONSTRAINT fk_login_attempts_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL;

ALTER TABLE login_attempts ADD CONSTRAINT fk_login_attempts_auth_event FOREIGN KEY (auth_event_id) REFERENCES auth_events(id) ON DELETE SET NULL;
