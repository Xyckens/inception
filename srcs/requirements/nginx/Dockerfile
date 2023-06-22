
FROM debian:buster

RUN apt update -y
RUN apt install -y nginx && apt install -y openssl

# https://devopscube.com/create-self-signed-certificates-openssl/
RUN mkdir -p /var/www/html

COPY ./tools/server /etc/nginx/sites-available
RUN ln -s /etc/nginx/sites-available/server /etc/nginx/sites-enabled/
RUN openssl req -x509 \
            -sha256 -days 356 \
            -nodes \
            -newkey rsa:2048 \
            -subj "/CN=www.fvieira.42.fr/C=PT/L=Porto" \
            -keyout /etc/ssl/private/nginx-selfsigned.key \
            -out /etc/ssl/certs/nginx-selfsigned.crt
EXPOSE 443

# https://stackoverflow.com/questions/18861300/how-to-run-nginx-within-a-docker-container-without-halting
CMD [ "nginx", "-g", "daemon off;" ]