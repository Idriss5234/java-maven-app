FROM openjdk:8-jre-alpine

EXPOSE 3000

COPY ./target/java-maven-jenkins-1.0-SNAPSHOT.jar /usr/app/
WORKDIR /usr/app

ENTRYPOINT [ "java","-jar","java-maven-jenkins-1.0-SNAPSHOT.jar" ]