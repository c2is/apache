FROM debian:stretch

RUN apt-get update && apt-get -y install apache2 libapache2-mod-fcgid && apt-get clean

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2

RUN mkdir /etc/apache2/ssl
RUN mkdir -p /var/www/website/web

RUN a2enmod proxy actions rewrite ssl headers

ADD conf/ssl.key /etc/apache2/ssl/ssl.key
ADD conf/ssl.crt /etc/apache2/ssl/ssl.crt

RUN usermod -u 1000 www-data

COPY entrypoint.sh /entrypoint.sh
RUN chmod 777 /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

RUN ln -s /etc/apache2/sites-available/vhost-website.conf /etc/apache2/sites-enabled/vhost-website.conf
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
EXPOSE 80
EXPOSE 443
