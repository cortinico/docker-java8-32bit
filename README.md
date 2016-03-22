# Java8 @32bit Docker container

Dockerfile for creating a 32bit Docker container with Java8 JRE.
The docker container can be downladed form the [Docker Hub](https://hub.docker.com/r/cortinico/java8-32bit/).

You can simply run it with
```bash
docker run -i cortinico/java8-32bit bash
```

## How to run a JAR inside the container
To run a Jar file you have to mount the */data volume*. Let's simply copy the Jar inside a folder (say ```/tmp/jar```):
```bash
mkdir /tmp/jar
cp myapp.jar /tmp/jar
```
And then run the Jar inside the container
```bash
docker run -i -v /tmp/jar:/data cortinico/java8-32bit java -jar myapp.jar
```

## How to build the container from the dockerfile
To build the container from this Dockerfile, simply clone the repo and invoke the ```docker build``` command.
```bash
git clone https://github.com/cortinico/docker-java8-32bit.git
cd docker-java8-32bit/
docker build .
```

## Licence
The following software is released under the [MIT Licence](https://github.com/cortinico/docker-java8-32bit/blob/master/LICENSE)
