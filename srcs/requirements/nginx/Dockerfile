FROM debian:stable

RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y nginx openssl

COPY conf/ /tmp/nginx

RUN mkdir -p /var/www && \
	mv /tmp/nginx/index.html /var/www/index.html

RUN mv /tmp/nginx/nginx.conf /etc/nginx/sites-available/nginx.conf && \
	rm -rf /etc/nginx/sites-enabled/* && \
	ln -sf /etc/nginx/sites-available/nginx.conf /etc/nginx/sites-enabled/nginx.conf

RUN openssl req \
		-newkey rsa:4096 \
		-x509 \
		-sha256 \
		-days 3560 \
		-nodes \
		-out /etc/ssl/certs/localhost.crt \
		-keyout /etc/ssl/private/localhost.key \
		-subj "/C=NL/ST=Noord-Holland/L=Amsterdam/O=YesMan/OU=Me/CN=www.localhost"

EXPOSE 443

CMD [ "nginx", "-g", "daemon off;" ]
