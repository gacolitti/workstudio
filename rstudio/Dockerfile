FROM openanalytics/shinyproxy-rstudio-ide-demo:2023.06.0_421__4.3.1

# Copy rstudio preferences 
RUN mkdir -p /etc/rstudio
COPY rstudio-prefs /etc/rstudio

# Add working directory and change permissions
RUN mkdir -p /home/rstudio/workstudio
RUN chmod -R a+rwx /home/rstudio/workstudio

RUN echo "session-timeout-minutes=0" >> /etc/rstudio/rsession.conf