#### Docker file to build reverse proxied elasticsearch ####

# Based on Ubuntu from Trevor Munoz

# Set base image

FROM ubuntu:14.04

# File maintainer
MAINTAINER Francis Kayiwa
# Update repo
RUN apt-get update
RUN apt-get install nginx -y

# clean up after ourselves
RUN rm -rf /var/lib/apt/lists/* && \
echo "daemon off;" >> /etc/nginx/nginx.conf && \
chown -R www-data:www-data /var/lib/nginx

# copy nginx config file
COPY search /etc/nginx/sites-available/

# symbolic link creation
RUN ln -s /etc/nginx/sites-available/search \
/etc/nginx/sites-enabled/search && \ 
rm -f /etc/nginx/sites-enabled/default

# bootstrap nginx
COPY bootstrap-nginx.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/bootstrap-nginx.sh

EXPOSE 80
EXPOSE 443

CMD ["nginx"]
