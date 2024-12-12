# Use an official Maven image as a parent image
FROM maven:3.8.4-openjdk-17-slim AS build

# Set the working directory in the container
WORKDIR /app

# Copy the project files into the container
COPY pom.xml .
COPY src ./src

# Build the application
RUN mvn clean package -DskipTests

# Use an official OpenJDK runtime as a parent image
FROM openjdk:17-jdk-slim

# Set the working directory in the container
WORKDIR /app

# Copy the built JAR file from the build stage
COPY --from=build /app/target/*.jar studentsystembackend.jar

# Expose the port the app runs on
EXPOSE 8080

# Run the jar file
ENTRYPOINT ["java","-jar","/app/studentsystembackend.jar"]