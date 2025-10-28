FROM webdevops/php-apache:7.4

# Corrige os repositórios do Debian Buster
RUN sed -i 's|deb.debian.org|archive.debian.org|g' /etc/apt/sources.list && \
    sed -i '/security.debian.org/d' /etc/apt/sources.list && \
    echo "deb http://archive.debian.org/debian buster main contrib non-free" > /etc/apt/sources.list && \
    echo "Acquire::Check-Valid-Until false;" > /etc/apt/apt.conf.d/99ignore-check-valid-until

# Instalação de dependências
RUN apt-get update && \
    apt-get install -y libaio1 libaio-dev wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Adiciona os arquivos instantclient
ADD instantclient-basic.zip /tmp/
ADD instantclient-sdk.zip /tmp/

# Cria diretórios necessários
RUN mkdir -p /opt/oracle && \
    mkdir -p /var/secrets

# Descompacta os arquivos instantclient
RUN unzip /tmp/instantclient-basic.zip -d /opt/oracle/ && \
    unzip /tmp/instantclient-sdk.zip -d /opt/oracle/ && \
    ln -s /opt/oracle/instantclient_19_21 /opt/oracle/instantclient

# Configura a variável de ambiente LD_LIBRARY_PATH
ENV LD_LIBRARY_PATH /opt/oracle/instantclient

# Instala a extensão oci8
RUN echo 'instantclient,/opt/oracle/instantclient' | pecl install oci8-2.2.0 && \
    echo "extension=oci8" >> /usr/local/etc/php/conf.d/custom-oci8.ini

# Instala a extensão pdo_oci
RUN docker-php-ext-configure pdo_oci --with-pdo-oci=instantclient,/opt/oracle/instantclient && \
    docker-php-ext-install pdo_oci

# Instala o PhantomJS
RUN apt-get update && \
    apt-get install -y wget && \
    wget https://arquivos.rodrigozanotta.com.br/phantomjs-2.1.1-linux-x86_64.tar.bz2 && \
    tar xvjf phantomjs-2.1.1-linux-x86_64.tar.bz2 -C /usr/local/share/ && \
    ln -s /usr/local/share/phantomjs-2.1.1-linux-x86_64/bin/phantomjs /usr/local/bin/ && \
    rm phantomjs-2.1.1-linux-x86_64.tar.bz2 && \
    apt-get remove -y wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Reinicia o serviço Apache
RUN service apache2 restart

#RUN export OPENSSL_CONF=/etc/ssl/
#ENV OPENSSL_CONF /etc/ssl/
