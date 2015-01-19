FROM dockerfile/java:oracle-java8
MAINTAINER info@exteso.com
ADD https://github.com/exteso/alf.io/releases/download/alfio-1.3-beta1/alfio-1.3-beta1-jetty-console.war /usr/local/apps/alfio.war
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/usr/local/apps/alfio.war", "--headless"]
