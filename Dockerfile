FROM openjdk:11
LABEL product=shinyproxy
RUN wget -P /opt/shinyproxy https://www.shinyproxy.io/downloads/shinyproxy-3.0.2.jar
COPY application.yml /opt/shinyproxy/application.yml
RUN chmod +x /opt/shinyproxy/shinyproxy-3.0.2.jar
WORKDIR /opt/shinyproxy/
CMD ["java", "-jar", "shinyproxy-3.0.2.jar"]