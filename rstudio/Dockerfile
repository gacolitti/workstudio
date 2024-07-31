FROM rocker/rstudio:4.4
# NB: this file is only used by rocker if the 
# env var DISABLE_AUTH: true is specified in the application.yml
RUN echo "www-frame-origin=same" >> /etc/rstudio/disable_auth_rserver.conf
RUN echo "www-verify-user-agent=0" >> /etc/rstudio/disable_auth_rserver.conf

ADD setup-root-path.sh /etc/cont-init.d/03_setup_root_path.sh

# By default RStudio does not give access to all enviornment variables 
# defined in the container (e.g. using ShinyProxy).
# Uncomment the next line, to change this behavior.
# ADD copy-env.sh /etc/cont-init.d/04_copy_env.sh

# Essential vars
ENV RENV_PATHS_CACHE=/home/rstudio/renv/cache
ENV R_LIBS_USER=/usr/local/lib/R/site-library

#ENV PYTHON_VENV_PATH /pyenv
RUN /rocker_scripts/install_python.sh
RUN /rocker_scripts/install_tidyverse.sh
RUN /rocker_scripts/install_pandoc.sh
RUN /rocker_scripts/install_texlive.sh
RUN /rocker_scripts/install_verse.sh
RUN /rocker_scripts/install_geospatial.sh

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