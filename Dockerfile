# Use the official Ubuntu image as the base image
FROM ubuntu:latest

# Install dependencies: ttyd, php, curl, ca-certificates
RUN apt-get update && \
    apt-get install -y ttyd python3 python3-pip curl ca-certificates && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
    
# Set the working directory
WORKDIR /app

# Download the script
RUN curl -o script.php https://raw.githubusercontent.com/rabiuhadisalisu/xtx/main/requirements.txt

RUN pip3 install --no-cache-dir -r requirements.txt

RUN curl -o script.php https://raw.githubusercontent.com/rabiuhadisalisu/xtx/main/qual.py

# Expose port 80
EXPOSE 80

# Start ttyd on port 80 to run the PHP script
CMD ["ttyd", "-i", "0.0.0.0", "-p", "80", "python3", "/app/script.py"]
