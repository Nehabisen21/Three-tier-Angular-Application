# Use an official Maven image to build the application
FROM maven:3.8.6-openjdk-8 AS build

# Set the working directory in the container
WORKDIR /app

# Copy the source code into the container
COPY . .

# Build the application
RUN mvn clean package -DskipTests=true

# Use an official OpenJDK image to run the application
FROM openjdk:8-jdk-slim AS runtime

# Set the working directory in the container
WORKDIR /app

# Copy the built JAR file from the previous stage
COPY --from=build /app/target/*.jar app.jar

# Expose the application port (default is 8080)
EXPOSE 8080

# Set the command to run the application
CMD ["java", "-jar", "app.jar"]

