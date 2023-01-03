FROM debian:buster

RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y nginx

COPY conf/ /tmp/nginx

RUN mkdir -p /var/www && \
	mv /tmp/nginx/index.html /var/www/index.html

RUN mv /tmp/nginx/nginx.conf /etc/nginx/sites-available/nginx.conf && \
	rm -rf /etc/nginx/sites-enabled/* && \
	ln -sf /etc/nginx/sites-available/nginx.conf /etc/nginx/sites-enabled/nginx.conf

# EXPOSE 443
EXPOSE 80

CMD nginx -g 'daemon off;'
# CMD tail -f
