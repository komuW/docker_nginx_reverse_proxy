# Docker Nginx Reverse Proxy        



This is an nginx image to enable you to use it as a reverse proxy to another container.                    



Let's say you have a container running your app/server and you would like to have nginx reverse proxy to it.                               
You just define a few environment variables and you are on your way.                          


$ cat docker-compose.yml                                  
`version: '2'`                             
`services:`                       
&nbsp;&nbsp;&nbsp;&nbsp;`mynginx:`                                   
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`image: komuw/docker_nginx_reverse_proxy`                              
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`links:`                       
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`- myapp:myapp`                      
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`volumes_from:`                           
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`- myapp`                    
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`ports:`                              
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`- 80:80`                      
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`environment:`                         
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`- UPSTREAM_NAME=myapp`                     
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`- UPSTREAM_PORT=6379`             
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`- NGINX_EXPOSED_PORT=80`              
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`- UPSTREAM_STATICFILE_LOCATION=/usr/src/app/static`             


&nbsp;&nbsp;&nbsp;&nbsp;`myapp:`                                 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`image: python:3.5-alpine`                               
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`command: python -m SimpleHTTPServer 9090`                 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`volumes:`                     
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`- ./:/usr/src/app`                                             


$ docker-compose up 



The enviroment variables that you can define(with their default values) are;            
NGINX_PORT=80                                  
NGINX_CACHE_DIR=/etc/nginx/cache_dir                                  
NGINX_CACHE_NAME=my_nginx_cache                                  
UPSTREAM_NAME=web                                  
UPSTREAM_PORT=3000                                  
WORKER_PROCESSES=2                                  
WORKER_CONNECTIONS=1024                                  
ENV UPSTREAM_STATICFILE_LOCATION=/app/upstream/src/static                                 

NGINX_PORT - the port at which you want nginx to listen on inside the container       
NGINX_EXPOSED_PORT - the port on the host that nginx is exposed at                                       
NGINX_CACHE_DIR - the location of the nginx cache                                  
NGINX_CACHE_NAME - nginx cache name                                  
UPSTREAM_PORT - the port where the app/service/container is listening on. This is the port inside that container and not the port that is mapped to on the host.                                   
    for that reason, that container need to be linked into the docker_nginx_reverse_proxy conatiner.                                  
WORKER_PROCESSES - number of nginx worker processes[1]                                  
WORKER_CONNECTIONS - number of nginx worker connections[2]                                  
ENV UPSTREAM_STATICFILE_LOCATION - the location of staticfiles(css, js etc) inside the upstream container.                                  


# usage:                                   
$ docker run komuw/docker_nginx_reverse_proxy                                  


# references:                                  
1. http://nginx.org/en/docs/ngx_core_module.html#worker_processes                                  
2. http://nginx.org/en/docs/ngx_core_module.html#worker_connections                                  
