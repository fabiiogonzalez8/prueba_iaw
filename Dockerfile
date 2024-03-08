# syntax=docker/dockerfile:1
FROM debian
RUN apt-get update && apt-get install -y apache2 libapache2-mod-php php mariadb-client php-mysql && apt-get clean && rm -rf /var/lib/apt/lists/*
COPY src /var/www/html/
COPY src/database.sql /opt/
RUN rm /var/www/html/index.html
ENV DB_USER fabio
ENV DB_PASSWORD usuario
ENV DB_NAME examen
ENV DB_HOST servidor_examen
ENV BASE_URL http://localhost:8888/
COPY script.sh /usr/local/bin/script.sh
RUN chmod +x /usr/local/bin/script.sh
RUN a2enmod rewrite
COPY apache2.conf /etc/apache2/apache2.conf
EXPOSE 80
CMD /usr/local/bin/script.sh
