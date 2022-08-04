### Builder Configuration
FROM maven:3.8.6-openjdk-11-slim as BUILDER
ARG VERSION=0.0.1-SNAPSHOT
WORKDIR /build/
COPY pom.xml /build/
COPY src /build/src/

### Packaging
RUN mvn clean package
COPY target/booting-web-${VERSION}.jar target/application.jar

### Building Final Docker Image
FROM openjdk:11.0.12-jre-slim
WORKDIR /app/
COPY --from=BUILDER /build/target/application.jar /app/
CMD java -jar /app/application.jar