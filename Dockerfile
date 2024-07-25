# Use the official Ubuntu image as the base image
FROM ubuntu:latest

# Install dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends ttyd curl php && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Download the script and make it executable
RUN curl -o /usr/local/bin/script.php https://raw.githubusercontent.com/rabiuhadisalisu/xtx/main/dodirect.php && \
    chmod +x /usr/local/bin/script.php

# Set the working directory (optional, but good practice)
WORKDIR /app

# Expose port 80 (for web traffic)
EXPOSE 80

# Start the PHP script in the background, and ttyd for interactive shell access
CMD ["/usr/local/bin/script.php", "&", "ttyd", "-p", "80", "bash"]
