FROM openanalytics/shinyproxy-rstudio-ide-demo:2023.06.0_421__4.3.1

# Essential vars
ENV RENV_PATHS_CACHE=/home/rstudio/renv/cache

# Update and install all required packages in one layer
RUN apt-get update && \
    apt-get install -y \
    openssh-server \
    apt-transport-https \
    curl \
    nano \
    iputils-ping \
    postgresql \ 
    postgresql-contrib \
    odbc-postgresql \
    libpq-dev \
    libssl-dev \
    libpq5 \
    pkg-config \
    zlib1g-dev \ 
    libsodium-dev \ 
    --no-install-recommends && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
    
# Copy rstudio preferences 
RUN mkdir -p /etc/rstudio
COPY rstudio-prefs /etc/rstudio

# Create necessary directories and set permissions
RUN mkdir -p /home/rstudio/workstudio \
    && mkdir -p /home/rstudio/renv/cache \
    && chmod -R a+rwx /home/rstudio 

RUN echo "session-timeout-minutes=0" >> /etc/rstudio/rsession.conf