# Use the official Ubuntu image as the base image
FROM ubuntu:latest

# Install dependencies: ttyd, bash, curl
RUN apt-get update && \
    apt-get install -y ttyd curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Download the script
RUN curl -o /root/script.php https://raw.githubusercontent.com/rabiuhadisalisu/xtx/main/dodirect.php

# Expose port 80
EXPOSE 80

# Start ttyd on port 80 with bash as the shell
CMD ["ttyd", "-i", "-p", "80", "bash"]
