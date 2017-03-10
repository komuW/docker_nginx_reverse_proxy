# Docker Nginx Reverse Proxy        



This is an nginx image to enable you to use it as a reverse proxy to another container.                    



Let's say you have a container running your app/server and you would like to have nginx reverse proxy to it.                               
You just define a few environment variables and you are on your way.                          


$ `cat docker-compose.yml`
version: '2'
services:
  mynginx:
    image: komuw/docker_nginx_reverse_proxy:v1
    links:
      - myredis:myredis
    ports:
      - 80:80
    environment:
      - UPSTREAM_NAME=myredis
      - UPSTREAM_PORT=6379

  myredis:
    image: redis:3.0

$ docker-compose up 



The enviroment variables that you can define(with their default values) are;            
NGINX_PORT=80
NGINX_CACHE_DIR=/etc/nginx/cache_dir
NGINX_CACHE_NAME=my_nginx_cache
UPSTREAM_NAME=web
UPSTREAM_PORT=3000
WORKER_PROCESSES=2
WORKER_CONNECTIONS=1024
UPSTREAM_SRC_LOCATION=/app/upstream/src

NGINX_PORT - the port at which you want nginx to listen on inside the container
NGINX_CACHE_DIR - the location of the nginx cache
NGINX_CACHE_NAME - nginx cache name
UPSTREAM_PORT - the port where the app/service/container is listening on. This is the port inside that container and not the port that is mapped to on the host. 
    for that reason, that container need to be linked into the docker_nginx_reverse_proxy conatiner.
WORKER_PROCESSES - number of nginx worker processes[1]
WORKER_CONNECTIONS - number of nginx worker connections[2]
UPSTREAM_SRC_LOCATION - the location inside the docker_nginx_reverse_proxy container where the source of the current directory will be saved in.


references:
1. http://nginx.org/en/docs/ngx_core_module.html#worker_processes
2. http://nginx.org/en/docs/ngx_core_module.html#worker_connections