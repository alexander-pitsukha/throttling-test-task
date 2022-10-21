FROM maven:3.8.6-amazoncorretto-11 AS build
COPY src /usr/src/app/src
COPY pom.xml /usr/src/app
RUN mvn -f /usr/src/app/pom.xml clean package -DskipTests=true

FROM amazoncorretto:11-alpine3.15
COPY --from=build /usr/src/app/target/throttling-test-task-0.0.1-SNAPSHOT.jar /usr/app/throttling-test-task.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/usr/app/throttling-test-task.jar"]
