FROM maven:3.9.0-eclipse-temurin-17 AS build

WORKDIR /app

COPY . .

RUN mvn -N io.takari:maven:wrapper

RUN chmod +x mvnw

RUN mvn clean install -DskipTests

FROM eclipse-temurin:17-jre

WORKDIR /app

COPY --from=build /app/outcome-curr-mgmt/target/*.jar /app/outcome-curr-mgmt.ja

EXPOSE 9092

CMD ["java", "-jar", "/app/outcurr-app.jar"]