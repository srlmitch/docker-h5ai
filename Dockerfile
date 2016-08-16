FROM ubuntu:trusty
MAINTAINER Ben Sarmiento <me@bensarmiento.com>

RUN apt-get update && apt-get install -y nginx php5-fpm supervisor wget unzip patch

# download latest release
RUN wget http://hackz.co.uk/_h5ai.zip
RUN unzip _h5ai.zip -d /usr/share/h5ai

ADD h5ai.nginx.conf /etc/nginx/sites-available/default

ADD h5ai-path.patch patch
RUN patch -p1 -u -d /usr/share/h5ai/_h5ai/private/php/core/ -i /patch && rm patch

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
CMD supervisord -c /etc/supervisor/conf.d/supervisord.conf

EXPOSE 80

VOLUME /var/www
