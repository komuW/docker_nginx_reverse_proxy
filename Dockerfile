FROM nginx:1.11

LABEL maintainer "komuw05@gmail.com"

ENV NGINX_PORT=80
ENV NGINX_CACHE_DIR=/etc/nginx/cache_dir
ENV NGINX_CACHE_NAME=my_nginx_cache
ENV UPSTREAM_NAME=web
ENV UPSTREAM_PORT=3000
ENV WORKER_PROCESSES=2
ENV WORKER_CONNECTIONS=1024
ENV UPSTREAM_SRC_LOCATION=/app/upstream/src

COPY nginx.conf /etc/nginx/nginx.conf

ONBUILD ADD . $UPSTREAM_SRC_LOCATION

CMD envsubst '${NGINX_PORT},${NGINX_CACHE_DIR},${NGINX_CACHE_NAME},${UPSTREAM_NAME},${UPSTREAM_PORT},${WORKER_PROCESSES},${WORKER_CONNECTIONS},${UPSTREAM_SRC_LOCATION}' < /etc/nginx/nginx.conf > /tmp/nginx.conf && \
              mv /tmp/nginx.conf /etc/nginx/nginx.conf && \
              nginx -g 'daemon off;'
