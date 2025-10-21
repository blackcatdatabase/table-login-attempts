<!-- Auto-generated from schema-map.psd1 @ 1e83bb6 (2025-10-21T10:18:36+02:00) -->
# Definition – login_attempts

Login attempts per IP and (optional) user.

## Columns
| Column | Type | Null | Default | Description | Notes |
|-------:|:-----|:----:|:--------|:------------|:------|
| id | BIGINT UNSIGNED | NO | — | Surrogate primary key. |  |
| ip_hash | BINARY(32) | NO | — | Hashed client IP. | PII: hashed |
| attempted_at | DATETIME(6) | NO | CURRENT_TIMESTAMP(6) | Attempt time (UTC). |  |
| success | BOOLEAN | NO | 0 | Whether authentication succeeded. |  |
| user_id | BIGINT UNSIGNED | YES | — | User (FK users.id), optional. |  |
| username_hash | BINARY(32) | YES | — | Hashed username/email provided. | PII: hashed |
| auth_event_id | BIGINT UNSIGNED | YES | — | Link to auth_events record, optional. |  |
