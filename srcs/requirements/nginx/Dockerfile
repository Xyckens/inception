
FROM debian:bullseye

EXPOSE 443

RUN apt update -y && apt install -y nginx openssl

# https://devopscube.com/create-self-signed-certificates-openssl/
RUN mkdir -p /var/www/html

COPY ./tools/init.sh /tmp/init.sh
COPY ./tools/nginx.conf /etc/nginx/sites-available/default

RUN chmod +x /tmp/init.sh

# https://stackoverflow.com/questions/18861300/how-to-run-nginx-within-a-docker-container-without-halting
CMD ["nginx", "-g", "daemon off;"]
