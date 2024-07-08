FROM openjdk:17-jdk-slim
LABEL product=shinyproxy

# Install wget
RUN apt-get update && apt-get install -y wget && apt-get clean

RUN wget -P /opt/shinyproxy https://www.shinyproxy.io/downloads/shinyproxy-3.1.0.jar
RUN chmod +x /opt/shinyproxy/shinyproxy-3.1.0.jar
WORKDIR /opt/shinyproxy/
CMD ["java", "-jar", "shinyproxy-3.1.0.jar"]