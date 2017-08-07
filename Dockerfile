FROM debian:jessie 

# File Author / Maintainer
MAINTAINER Bernhard Esperester <bernhard@esperester.de>

# update apt-get
RUN apt-get update && apt-get -y dist-upgrade && apt-get -y autoremove

# install apache
RUN apt-get update && apt-get -y install apache2 && apt-get clean && rm -rf /var/lib/apt/lists/*

# configure apache
ENV APACHE_RUN_USER www-data 
ENV APACHE_RUN_GROUP www-data 
ENV APACHE_LOG_DIR /var/log/apache2 

# enable ssl
RUN /usr/sbin/a2ensite default-ssl
RUN /usr/sbin/a2enmod ssl

# expose ports
EXPOSE 80 
EXPOSE 443 

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]