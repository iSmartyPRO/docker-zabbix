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

## Nginx Config
```
server {
  listen 80;
  server_name zabbix.bglobal.kg;
  return 301 https://$server_name$request_uri;
}
server {
        listen              443 ssl;
        server_name         zabbix.example.com;
        # LOGS
        access_log /var/log/nginx/zabbix.example.com-access.log;
        error_log /var/log/nginx/zabbix.example.com-error.log;

        client_max_body_size 0;
        underscores_in_headers on;
        # SSL Certs
        ssl_certificate /etc/letsencrypt/live/zabbix.example.com/fullchain.pem;
        ssl_certificate_key /etc/letsencrypt/live/zabbix.example.com/privkey.pem;

        ssl_stapling on;
        ssl_stapling_verify on;
        location / {
                proxy_headers_hash_max_size 512;
                proxy_headers_hash_bucket_size 64;
                proxy_set_header Host $host;
                proxy_set_header X-Forwarded-Proto $scheme;
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;

                add_header Front-End-Https on;
                # whatever the IP of your cloud server is
                proxy_pass http://192.168.99.2:8080;
        }
    location /.well-known/acme-challenge/ {
        root /var/www/certbot;
    }
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

Логин: Admin
Пароль: zabbix

Рекомендуется сразу же сменить пароль.

# Установка Zabbix Agent

## На windows можно установить Zabbix Agent через Chocolatey
```
cinst zabbix-agent -y
```
редактирование конфигурации после установки через Chocolatey
```
code C:\ProgramData\zabbix\zabbix_agentd.conf
```
после обновления конфигурации перезагружаем службу:
```
Restart-Service "Zabbix Agent"
```

# Открытие порта для Zabbix Agent
## На Windows через PowerShell
```
New-NetFirewallRule -DisplayName "Allow Zabbix Agent 10050/tcp" -Direction inbound -Profile Any -Action Allow -LocalPort 10050 -Protocol TCP
```


## Дополнение
После установки, необходимо изменить конфигурацию для Zabbix-server - необходимо вместо IP 127.0.0.1 указать DNS Zabbix-server, после чего будет корректно собираться данные Zabbix сервера.
