# Stage 1: Build the application
FROM maven:3.8.3-openjdk-17 AS build

WORKDIR /src 

COPY . /src 

RUN mvn clean install -DskipTests=true

# Stage 2: Create the runtime image

FROM maven:3.8.3-openjdk-17 AS runtime

COPY --from=build /src/target/*.jar /src/target/bankapp.jar

EXPOSE 8080

CMD ["java","-jar","/src/target/bankapp.jar"]


