# Start with the Rocker R-Ver base image
FROM rocker/r-ver:4.4

# Update and install all required packages in one layer
RUN apt-get update && \
    apt-get install -y \
    openssh-server \
    apt-transport-https \
    curl \
    nano \
    git \
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

# Use Rocker script to install Python
RUN /rocker_scripts/install_python.sh

# Setup paths to R libraries
ENV RENV_PATHS_CACHE=/home/rstudio/renv/cache
ENV R_LIBS_USER=/usr/local/lib/R/site-library

# Install other dependencies and R packages
RUN /rocker_scripts/install_tidyverse.sh
RUN /rocker_scripts/install_pandoc.sh
RUN /rocker_scripts/install_texlive.sh
RUN /rocker_scripts/install_verse.sh
RUN /rocker_scripts/install_geospatial.sh

# Install code-server
RUN curl -fsSL https://code-server.dev/install.sh | sh

# Create a directory for code-server
RUN mkdir -p /root/.local/share/code-server

# Install extensions for Python, PowerShell, Markdown
RUN code-server --install-extension ms-python.python && \
    code-server --install-extension ms-vscode.powershell && \
    code-server --install-extension yzhang.markdown-all-in-one

# Copy settings and snippets (if you have these files)
COPY User/settings.json /root/.local/share/code-server/User/settings.json
COPY User/snippets /root/.local/share/code-server/User/snippets

# Create necessary directories and set permissions
RUN mkdir -p /home/vscode/workstudio \
    && mkdir -p /home/vscode/renv/cache \
    && chmod -R a+rwx /home/vscode 
    
WORKDIR /home/vscode/workstudio

# Set up entrypoint
ENTRYPOINT ["code-server", "--bind-addr", "0.0.0.0:8090", "--auth", "none"]

# Expose the port
EXPOSE 8090
