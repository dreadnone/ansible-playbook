#!/bin/bash
echo "Установка ролей из requirements.yml..."
ansible-galaxy install -r requirements.yml -p roles/

echo "Проверка установленных ролей:"
ls -la roles/
