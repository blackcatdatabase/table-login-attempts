<!-- Auto-generated from schema-map-postgres.psd1 @ 62c9c93 (2025-11-20T21:38:11+01:00) -->
# Definition – login_attempts

Login attempts per IP and (optional) user.

## Columns
| Column | Type | Null | Default | Description | Notes |
|-------:|:-----|:----:|:--------|:------------|:------|
| id | BIGINT | NO | AS | Surrogate primary key. |  |
| ip_hash | BYTEA | NO | — | Hashed client IP. | PII: hashed |
| attempted_at | TIMESTAMPTZ(6) | NO | CURRENT_TIMESTAMP(6) | Attempt time (UTC). |  |
| success | BOOLEAN | NO | FALSE | Whether authentication succeeded. |  |
| user_id | BIGINT | YES | — | User (FK users.id), optional. |  |
| username_hash | BYTEA | YES | — | Hashed username/email provided. | PII: hashed |
| auth_event_id | BIGINT | YES | — | Link to auth_events record, optional. |  |