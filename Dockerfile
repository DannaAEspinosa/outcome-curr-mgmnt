FROM maven:3.8.8-eclipse-temurin-17 AS build

WORKDIR /app
COPY . .

RUN mvn clean install -DskipTests

FROM eclipse-temurin:17-jre

COPY --from=build /app/outcome-curr-mgmt/target/outcome-curr-mgmt-1.0-SNAPSHOT.jar /app/outcome.jar

#PUERTO DONDE SE EXPONDRÁ
EXPOSE 8081 

CMD ["java", "-jar", "/app/outcome.jar"]
