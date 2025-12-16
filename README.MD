
# Infrastructure Monitoring Playbook

Playbook для развертывания мониторинговой инфраструктуры:
- ClickHouse (база данных)
- Vector (сборщик логов и метрик)
- NGINX + Lighthouse (веб-интерфейс)

## Архитектура

Приложения → Vector → ClickHouse → Lighthouse (веб-интерфейс)
text


## Что делает playbook:

Playbook разворачивает на заданных хостах следующие приложения:

1. На хосте `lighthouse`:
   - NGINX (веб-сервер)
   - Git
   - Lighthouse (веб-интерфейс для ClickHouse)

2. На хосте `clickhouse`:
   - clickhouse-client
   - clickhouse-server  
   - clickhouse-common
   - Создает базу данных

3. На хосте `vector`:
   - Vector (сборщик логов и метрик)
   - Настраивает отправку данных в ClickHouse

## Параметры

1. IP адреса целевых хостов указаны в файле `inventory/prod.yml`
2. Версии пакетов и параметры конфигурации в `group_vars/vars.yml`
3. Vector настроен для отправки данных в ClickHouse через sinks конфигурацию

## Теги
- `nginx` - установка NGINX
- `lighthouse` - установка Lighthouse
- `clickhouse` - установка ClickHouse  
- `vector` - установка Vector

## Подготовка к запуску

Playbook использует Roles. Перед запуском инициализируйте роли:

```bash
ansible-galaxy install -r requirements.yml

Запуск

Установить всё сразу:
bash

ansible-playbook -i inventory/prod.yml site.yml

Установить отдельные компоненты:
bash

# Только NGINX
ansible-playbook -i inventory/prod.yml site.yml --tags nginx

# Только Lighthouse
ansible-playbook -i inventory/prod.yml site.yml --tags lighthouse

# Только ClickHouse
ansible-playbook -i inventory/prod.yml site.yml --tags clickhouse

# Только Vector
ansible-playbook -i inventory/prod.yml site.yml --tags vector

Vector Sinks Configuration

Vector предварительно настроен для отправки данных в ClickHouse:
yaml

vector_sinks:
  clickhouse_logs:
    type: clickhouse
    inputs:
      - system_logs
      - demo_metrics
    host: "{{ clickhouse_host }}"
    port: 8123
    database: "logs"
    table: "vector_data"
    skip_unknown_fields: true

Структура проекта
text

ansible-final-project/
├── site.yml              # Основной playbook
├── requirements.yml      # Зависимости (роли)
├── README.md            # Документация
├── inventory/
│   └── prod.yml         # Инвентарь хостов
├── group_vars/
│   └── vars.yml         # Переменные
└── templates/           # Шаблоны конфигураций

Зависимости

    Ansible 2.9+

    Доступ к хостам по SSH

    Права sudo на целевых хостах
    EOF