# Build Stage
FROM maven:3.6.3-openjdk-8 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Run Stage
FROM openjdk:8-jdk-alpine
WORKDIR /app

# Copy the correct .jar file from the build stage
COPY --from=build /app/target/spring-boot-security-jwt-mongodb-0.0.1-SNAPSHOT.jar app.jar

# Debug: List the contents of the /app folder to confirm the file is there
RUN ls -l /app

# Expose port 8080 for the Spring Boot application
EXPOSE 8080

# Start the Spring Boot application
ENTRYPOINT ["java", "-jar", "app.jar"]