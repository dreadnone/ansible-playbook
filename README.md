# Ansible Infrastructure Monitoring

Установка ClickHouse, Vector и Lighthouse.

## Структура

ansible-monitoring/
├── inventory.yml # Инвентарь хостов
├── site.yml # Основной playbook
├── requirements.yml # Зависимости (роли)
├── roles/ # Локальные роли
│ ├── vector-role/ # Роль Vector
│ └── lighthouse-role/ # Роль Lighthouse
└── group_vars/ # Переменные
text


## Использование

1. Установить роли:
```bash
./install_roles.sh

    Проверить синтаксис:

bash

ansible-playbook site.yml --syntax-check

    Запустить установку:

bash

# Всё вместе
ansible-playbook site.yml

Конфигурация Vector Sinks

В файле roles/vector-role/defaults/main.yml:
yaml

vector_sinks:
  clickhouse_logs:
    type: clickhouse          # Тип назначения
    inputs:                   # Источники данных
      - system_logs
    host: "localhost"         # Хост ClickHouse
    port: 8123               # Порт ClickHouse
    database: "logs"         # Имя базы данных
    table: "system_data"     # Имя таблицы

