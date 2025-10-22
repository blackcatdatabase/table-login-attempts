# 📦 Login Attempts

![SQL](https://img.shields.io/badge/SQL-MySQL%208.0%2B-4479A1?logo=mysql&logoColor=white) ![License](https://img.shields.io/badge/license-BlackCat%20Proprietary-red) ![Status](https://img.shields.io/badge/status-stable-informational) ![Generated](https://img.shields.io/badge/generated-from%20schema--map-blue)

<!-- Auto-generated from schema-map.psd1 @ 1e83bb6 (2025-10-21T10:18:36+02:00) -->

> Schema package for table **login_attempts** (repo: `login-attempts`).

## Files
```
schema/
  001_table.sql
  # (no deferred indexes declared in map)
  030_foreign_keys.sql
```

## Quick apply
```bash
# Apply schema (Linux/macOS):
mysql -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" < schema/001_table.sql
mysql -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" < schema/030_foreign_keys.sql
```

```powershell
# Apply schema (Windows PowerShell):
mysql -h $env:DB_HOST -u $env:DB_USER -p$env:DB_PASS $env:DB_NAME < schema/001_table.sql
mysql -h $env:DB_HOST -u $env:DB_USER -p$env:DB_PASS $env:DB_NAME < schema/030_foreign_keys.sql
```

## Docker quickstart
```bash
# Spin up a throwaway MySQL and apply just this package:
docker run --rm -e MYSQL_ROOT_PASSWORD=root -e MYSQL_DATABASE=app -p 3307:3306 -d mysql:8
sleep 15
mysql -h 127.0.0.1 -P 3307 -u root -proot app < schema/001_table.sql
mysql -h 127.0.0.1 -P 3307 -u root -proot app < schema/030_foreign_keys.sql
```

## Columns
| Column | Type | Null | Default | Extra |
|-------:|:-----|:----:|:--------|:------|
| id | BIGINT UNSIGNED | NO | — | AUTO_INCREMENT, PK |
| ip_hash | BINARY(32) | NO | — |  |
| attempted_at | DATETIME(6) | NO | CURRENT_TIMESTAMP(6) |  |
| success | BOOLEAN | NO | 0 |  |
| user_id | BIGINT UNSIGNED | YES | — |  |
| username_hash | BINARY(32) | YES | — |  |
| auth_event_id | BIGINT UNSIGNED | YES | — |  |

## Relationships
- FK → **auth_events** via (auth_event_id) (ON DELETE SET NULL).
- FK → **users** via (user_id) (ON DELETE SET NULL).

```mermaid
erDiagram
  LOGIN_ATTEMPTS {
    INT id PK
    BLOB ip_hash
    DATETIME attempted_at
    BOOLEAN success
    INT user_id
    BLOB username_hash
    INT auth_event_id
  }
  LOGIN_ATTEMPTS }o--|| AUTH_EVENTS : "auth_event_id"
  LOGIN_ATTEMPTS }o--|| USERS : "user_id"
```

## Indexes
- No deferred indexes declared for this table.

## Notes
- Generated from the umbrella repository **blackcat-database** using `scripts/schema-map.psd1`.
- To change the schema, update the map and re-run the generators.

## License
Distributed under the **BlackCat Store Proprietary License v1.0**. See `LICENSE`.
