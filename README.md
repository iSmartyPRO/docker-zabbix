# Краткое описание
Система ИТ мониторинга.

# Устанавливаемые контейнеры
* zabbix-server-mysql
* zabbix-web-nginx-mysql
* zabbix-agent

# Как пользоваться

## Создание базы
```
mysql -uroot -pPassword -h 192.168.0.100
CREATE DATABASE zabbix CHARACTER SET utf8 COLLATE utf8_bin;
CREATE USER 'zabbix'@'%' IDENTIFIED BY 'some_password';
GRANT ALL PRIVILEGES ON zabbix.* TO 'zabbix'@'%';
FLUSH PRIVILEGES;
```


## Установка
```
docker-compose up -d
```

## Удаление
```
docker-compose down
```

## Пользователь по умолчанию

Логин: admin
Пароль: zabbix

Рекомендуется сразу же сменить пароль.

## Дополнение
После установки, необходимо изменить конфигурацию для Zabbix-server - необходимо вместо IP 127.0.0.1 указать DNS Zabbix-server, после чего будет корректно собираться данные Zabbix сервера.
