# login_attempts

Login attempts per IP and (optional) user.

## Columns
| Column | Type | Null | Default | Description | Crypto |
| --- | --- | --- | --- | --- | --- |
| id | BIGINT | NO |  | Surrogate primary key. |  |
| ip_hash | mysql: BINARY(32) / postgres: BYTEA | NO |  | Hashed client IP. | `hmac`<br/>ctx: `db.hmac.login_attempts.ip_hash`<br/>kv: `ip_hash_key_version` |
| ip_hash_key_version | VARCHAR(64) | YES |  | Key version for ip_hash. | key version for: `ip_hash` |
| attempted_at | mysql: DATETIME(6) / postgres: TIMESTAMPTZ(6) | NO | CURRENT_TIMESTAMP(6) | Attempt time (UTC). |  |
| success | BOOLEAN | NO | mysql: 0 / postgres: FALSE | Whether authentication succeeded. |  |
| user_id | BIGINT | YES |  | User (FK users.id), optional. |  |
| username_hash | mysql: BINARY(32) / postgres: BYTEA | YES |  | Hashed username/email provided. | `hmac`<br/>ctx: `db.hmac.login_attempts.username_hash`<br/>kv: `username_hash_key_version` |
| username_hash_key_version | VARCHAR(64) | YES |  | Key version for username_hash. | key version for: `username_hash` |
| auth_event_id | BIGINT | YES |  | Link to auth_events record, optional. |  |

## Engine Details

### mysql

Indexes:
| Name | Columns | SQL |
| --- | --- | --- |
| idx_login_attempted_at | attempted_at | INDEX idx_login_attempted_at (attempted_at) |
| idx_login_auth_event | auth_event_id | INDEX idx_login_auth_event (auth_event_id) |
| idx_login_ip_success_time | ip_hash,success,attempted_at | INDEX idx_login_ip_success_time (ip_hash, success, attempted_at) |
| idx_login_user_time | user_id,attempted_at | INDEX idx_login_user_time (user_id, attempted_at) |
| idx_login_username_hash | username_hash | INDEX idx_login_username_hash (username_hash) |

Foreign keys:
| Name | Columns | References | Actions |
| --- | --- | --- | --- |
| fk_login_attempts_auth_event | auth_event_id | auth_events(id) | ON DELETE SET |
| fk_login_attempts_user | user_id | users(id) | ON DELETE SET |

### postgres

Indexes:
| Name | Columns | SQL |
| --- | --- | --- |
| idx_login_attempted_at | attempted_at | CREATE INDEX IF NOT EXISTS idx_login_attempted_at ON login_attempts (attempted_at) |
| idx_login_auth_event | auth_event_id | CREATE INDEX IF NOT EXISTS idx_login_auth_event ON login_attempts (auth_event_id) |
| idx_login_ip_success_time | ip_hash,success,attempted_at | CREATE INDEX IF NOT EXISTS idx_login_ip_success_time ON login_attempts (ip_hash, success, attempted_at) |
| idx_login_user_time | user_id,attempted_at | CREATE INDEX IF NOT EXISTS idx_login_user_time ON login_attempts (user_id, attempted_at) |
| idx_login_username_hash | username_hash | CREATE INDEX IF NOT EXISTS idx_login_username_hash ON login_attempts (username_hash) |

Foreign keys:
| Name | Columns | References | Actions |
| --- | --- | --- | --- |
| fk_login_attempts_auth_event | auth_event_id | auth_events(id) | ON DELETE SET |
| fk_login_attempts_user | user_id | users(id) | ON DELETE SET |

## Engine differences

## Views
| View | Engine | Flags | File |
| --- | --- | --- | --- |
| vw_login_attempts | mysql | algorithm=MERGE, security=INVOKER | [../schema/040_views.mysql.sql](../schema/040_views.mysql.sql) |
| vw_login_attempts_activity | mysql | algorithm=TEMPTABLE, security=INVOKER | [../schema/040_views_joins.mysql.sql](../schema/040_views_joins.mysql.sql) |
| vw_login_hotspots_ip | mysql | algorithm=TEMPTABLE, security=INVOKER | [../schema/040_views_joins.mysql.sql](../schema/040_views_joins.mysql.sql) |
| vw_login_hotspots_user | mysql | algorithm=TEMPTABLE, security=INVOKER | [../schema/040_views_joins.mysql.sql](../schema/040_views_joins.mysql.sql) |
| vw_login_attempts | postgres |  | [../schema/040_views.postgres.sql](../schema/040_views.postgres.sql) |
| vw_login_attempts_activity | postgres |  | [../schema/040_views_joins.postgres.sql](../schema/040_views_joins.postgres.sql) |
| vw_login_hotspots_ip | postgres |  | [../schema/040_views_joins.postgres.sql](../schema/040_views_joins.postgres.sql) |
| vw_login_hotspots_user | postgres |  | [../schema/040_views_joins.postgres.sql](../schema/040_views_joins.postgres.sql) |
