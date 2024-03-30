FROM openjdk:8-jre-alpine

EXPOSE 3000

COPY ./target/my-app 1.0-SNAPSHOT /usr/app/
WORKDIR /usr/app

ENTRYPOINT [ "java","-jar","my-app 1.0-SNAPSHOT" ]