# Usando a imagem base Debian Bullseye
FROM debian:bullseye

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y nginx openssl && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/nginx/ssl

RUN openssl req -batch -x509 -sha256 -nodes -newkey rsa:2048 -days 365 \
    -keyout /etc/nginx/ssl/inception.key \
    -out /etc/nginx/ssl/inception.crt 

COPY ./conf/nginx.conf /etc/nginx/conf.d

RUN chmod 755 /var/www/html && \
    chown -R www-data:www-data /var/www/html

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
