


RUN apt-get update && apt-get upgrade -y
updates package index of ubuntu image, and upgrades the version of packages to the latest

docker build -t nginx_image .
ocker run -p 8080:80 nginx_image
