# Ansible Role: Vector

Роль для установки и настройки Vector (логи и метрики).

## Переменные

Основные переменные в `defaults/main.yml`:

### vector_sinks (куда отправлять данные)
```yaml
vector_sinks:
  clickhouse_logs:
    type: clickhouse          # Тип: ClickHouse
    inputs:                   # Какие источники отправлять
      - system_logs
    host: "localhost"         # Хост ClickHouse
    port: 8123                # Порт ClickHouse
    database: "logs"          # База данных
    table: "system_data"      # Таблица в базе

Пример использования
yaml

- hosts: servers
  roles:
    - role: vector-role
      vars:
        vector_sinks:
          my_clickhouse:
            type: clickhouse
            inputs: ["app_logs"]
            host: "db.example.com"
            port: 8123
            database: "app_logs_db"
            table: "logs_table"

