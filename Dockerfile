FROM webdevops/php-apache:8.2

# Instalação de dependências
RUN apt-get update && \
    apt-get install -y libaio1 libaio-dev wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/log/apache2

RUN echo 'ErrorLog /var/log/apache2/error.log\nCustomLog /var/log/apache2/access.log combined' \
    > /opt/docker/etc/httpd/conf.d/logging.conf