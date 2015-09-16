FROM ubuntu:14.04
MAINTAINER Budi Irawan <deerawan@gmail.com>

# Install packages
# - Git
# - Apache2
# - PHP5
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
  apache2 \
  php5 \
  php5-mysql \
  php5-curl \
  git \
  curl \
  build-essential \
  wget

# Install Node JS
RUN curl -sL https://deb.nodesource.com/setup | sudo bash -
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y nodejs

# Install PhantomJS
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
  chrpath \
  libssl-dev \
  libxft-dev \
  libfreetype6 \
  libfreetype6-dev \
  libfontconfig1 \
  libfontconfig1-dev \
  libicu52 \
  libjpeg8 \
  libfontconfig \
  libwebp5

RUN npm cache clean -f
RUN npm set strict-ssl false
#RUN npm install -g phantomjs2
RUN wget https://github.com/Pyppe/phantomjs2.0-ubuntu14.04x64/raw/master/bin/phantomjs
RUN chmod 755 phantomjs
RUN mv phantomjs /usr/bin
ENV PATH /usr/bin:$PATH

 # Enable apache rewrite module
RUN a2enmod rewrite
RUN service apache2 restart

 # Install composer
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer
ENV PATH /root/.composer/vendor/bin:$PATH

# Install composer asset
RUN composer global require "fxp/composer-asset-plugin:1.0.3" --prefer-source --no-interaction

# Install Codeception
RUN COMPOSER_PROCESS_TIMEOUT=2000 composer global require \
  "codeception/codeception=2.0.11" "codeception/specify=*" "codeception/verify=*" --no-interaction




