
# Define the build arguments
ARG INCLUDE_TIDYVERSE
ARG INCLUDE_JUPYTER
ARG INCLUDE_GEOSPATIAL
ARG TINYTEX_VERSION
ARG RSTUDIO_ROCKER_IMAGE_VERSION

FROM ghcr.io/rocker-org/rstudio:$RSTUDIO_ROCKER_IMAGE_VERSION

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
    libcurl4-openssl-dev \
    libpq5 \
    pkg-config \
    zlib1g-dev \ 
    libsodium-dev \ 
    --no-install-recommends && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Conditionally install additional dependencies
RUN if [ "$INCLUDE_TIDYVERSE" = "TRUE" ]; then /rocker_scripts/install_tidyverse.sh; fi
RUN if [ "$INCLUDE_JUPYTER" = "TRUE" ]; then /rocker_scripts/install_jupyter.sh; fi
RUN if [ "$INCLUDE_GEOSPATIAL" = "TRUE" ]; then /rocker_scripts/install_geospatial.sh; fi

# Copy rstudio preferences 
RUN mkdir -p /etc/rstudio
COPY rstudio-prefs /etc/rstudio

# Create necessary directories and set permissions
RUN mkdir -p /home/rstudio/workstudio \
    && mkdir -p /home/rstudio/renv/cache 

RUN echo "session-timeout-minutes=0" >> /etc/rstudio/rsession.conf

WORKDIR /home/rstudio

# Install the tinytex R package
RUN R -e "install.packages('tinytex')"

# Install TinyTeX using the tinytex R package
ENV HOME=/home/rstudio 
ENV TINYTEX_VERSION=${TINYTEX_VERSION}
RUN R -e "tinytex::install_tinytex(version = Sys.getenv('TINYTEX_VERSION'))"

ENV PATH=$PATH:/home/rstudio/bin
RUN chmod -R a+rwx /home/rstudio