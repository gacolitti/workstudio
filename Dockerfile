FROM openjdk:17-jdk-slim
LABEL product=shinyproxy

# Change ShinyProxy version here
ARG SHINYPROXY_VERSION=3.1.1

# Install wget
RUN apt-get update && apt-get install -y wget && apt-get clean

# Use the version variable and rename the file
RUN wget -P /opt/shinyproxy https://www.shinyproxy.io/downloads/shinyproxy-${SHINYPROXY_VERSION}.jar \
    && mv /opt/shinyproxy/shinyproxy-${SHINYPROXY_VERSION}.jar /opt/shinyproxy/shinyproxy.jar

RUN chmod +x /opt/shinyproxy/shinyproxy.jar
WORKDIR /opt/shinyproxy/
CMD ["java", "-jar", "shinyproxy.jar"]
