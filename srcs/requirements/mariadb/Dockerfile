FROM debian:bullseye

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y mariadb-server && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/lib/mysql /var/run/mysqld && \
    chown -R mysql:mysql /var/lib/mysql /var/run/mysqld && \
    chmod 755 /var/run/mysqld

RUN echo "[mysqld]" >> /etc/mysql/my.cnf && \
    echo "skip-networking=0" >> /etc/mysql/my.cnf && \
    echo "skip-bind-address" >> /etc/mysql/my.cnf

COPY ./tools/entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

USER mysql

EXPOSE 3306

ENTRYPOINT ["/entrypoint.sh"]
