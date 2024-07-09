FROM ubuntu:20.04

# Install dependencies
RUN apt-get update && \
    apt-get install -y wget curl tar && \
    rm -rf /var/lib/apt/lists/*

# Install code-server
RUN curl -fsSL https://code-server.dev/install.sh | sh

# Create a directory for code-server
RUN mkdir -p /root/.local/share/code-server

# Install extensions
RUN code-server --install-extension ms-python.python && \
    code-server --install-extension ms-vscode.powershell && \
    code-server --install-extension yzhang.markdown-all-in-one
    
# Copy settings and snippets
COPY User/settings.json /root/.local/share/code-server/User/settings.json
COPY User/snippets /root/.local/share/code-server/User/snippets

# Set up entrypoint
ENTRYPOINT ["code-server", "--bind-addr", "0.0.0.0:8090", "--auth", "none"]

# Expose the port
EXPOSE 8090
