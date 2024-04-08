FROM openjdk:8-jre-alpine

EXPOSE 3000

COPY ./target/my-app*.jar /usr/app/
WORKDIR /usr/app

CMD java -jar my-app*.jar