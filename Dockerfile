# Use the official Ubuntu image as the base image
FROM ubuntu:latest

# Install dependencies: ttyd, python, pip, curl, ca-certificates
RUN apt-get update && \
    apt-get install -y ttyd python3 python3-pip curl ca-certificates && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Download the requirements file
RUN curl -o requirements.txt https://raw.githubusercontent.com/rabiuhadisalisu/xtx/main/requirements.txt

# Install Python dependencies
RUN pip3 install --no-cache-dir -r requirements.txt

# Download the Python script
RUN curl -o script.py https://raw.githubusercontent.com/rabiuhadisalisu/xtx/main/qual.py

# Expose port 80
EXPOSE 80

# Start ttyd on port 80 to run the Python script
CMD ["ttyd", "-i", "0.0.0.0", "-p", "80", "python3", "/app/script.py"]
