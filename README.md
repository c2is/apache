# Apache container

### Usage

You can extends the current container and add your own vhost

```
FROM c2is/apache

# Add a vhost
ADD vhost.conf /etc/apache2/sites-available/

RUN /bin/ln -sf ../sites-available/vhost.conf /etc/apache2/sites-enabled/

```

### Vhost using php-fpm container

```
<VirtualHost *:80>
    ServerName symfony.local
    DocumentRoot "/var/www/symfony/web"

    <Directory /var/www/symfony/web>
        Order allow,deny
        Allow from all
    </Directory>

    RewriteEngine on
    RewriteRule ^/(.*\.php(/.*)?)$ fcgi://php:9000/var/www/symfony/web/$1 [L,P]
</VirtualHost>
```

The rewrite rule line is used to link the current container with php-fpm container (use the right port, define in your docker-compose.yml)