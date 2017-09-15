FROM php:7.0-cli

RUN set -x \
  && curl -sSL https://getcomposer.org/composer.phar -o /usr/local/bin/composer \
  && chmod +x /usr/local/bin/composer

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927 \
  && echo "deb http://repo.mongodb.org/apt/debian jessie/mongodb-org/3.2 main" | tee /etc/apt/sources.list.d/mongodb-org-3.2.list \
  && apt-get update \
  && apt-get install -y libicu-dev libcurl4-gnutls-dev libxml2-dev libssl-dev libmcrypt-dev git unzip mongodb-org-shell mysql-client --no-install-recommends \
  && rm -rf /var/lib/apt/lists/* \
  && docker-php-ext-install -j$(nproc) bcmath mcrypt pdo pdo_mysql mysqli dom json xml tokenizer curl mbstring simplexml intl soap \
  && pecl install mongodb \
  && pecl install apcu \
  && docker-php-ext-enable mongodb \
  && docker-php-ext-enable apcu
