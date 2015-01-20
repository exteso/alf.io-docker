# alf.io-docker
Dockerfiles to create all docker images required to run an instance of alf.io

## Pre-requisite
Install [Docker](https://docs.docker.com/installation/).

On Mac or Windows install and run also [Boot2Docker](http://boot2docker.io/) 

## TL;DR, I just want an instance up-and-running

### Download all alf.io docker images from docker hub
```
docker pull exteso/alfio-db
docker pull exteso/alfio-web
docker pull tutum/haproxy
```

### Launch Alf.io
Start an empty DB instance
```
docker run --name alfio-db -e DOCKER_DB_NAME=postgres -e POSTGRES_USERNAME=postgres -e POSTGRES_PASSWORD=alfiopassword -d exteso/alfio-db
```

Start the alf.io web application
```
docker run --name alfio-web --link alfio-db:db -d exteso/alfio-web
```
* Note: alfio-web requires https when accessing the web gui, thus you have to configure a proxy with SSL certificate in front of it. Only for TEST purposes, you can start alfio-web in http-only mode using the following command:
   ```
   docker run --name alfio-web --link alfio-db:db -e spring.profiles.active=http -d exteso/alfio-web
   ```

### Start a proxy

Create a .pem certificate and use it in the next command (here it is called "servercert.pem")
```
docker run --name alfio-proxy --link alfio-web:web1 -e SSL_CERT="$(awk 1 ORS='\\n' servercert.pem)" -e PORT=8080 -p 443:443 -d tutum/haproxy
```

## Create a new version of the images
Clone the alf.io-docker github repository
```
git clone https://github.com/exteso/alf.io-docker.git alf.io-docker
cd alf.io-docker
```

### Make a new version of the alfio-db image and publish on docker hub registry
```
cd alfio-db
```
edit Dockerfile or make_db.sh (currently we just create the DB and USER because alf.io intialize all the tables first time it is started)
```
docker build --tag=exteso/alfio-db:1.3.x .
docker push exteso/alfio-db:1.3.x
```

### Make a new version of the alfio-web image and publish on docker hub registry
```
cd alfio-web
```
edit Dockerfile to change the version of alf.io .war that you want to use in the new image
```
docker build --tag=exteso/alfio-web:1.3.x .
docker push exteso/alfio-web:1.3.x
```





