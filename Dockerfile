# Use the official Ubuntu image as the base image
FROM ubuntu:latest

# Install dependencies: ttyd, python, pip, curl, ca-certificates
RUN apt-get update && \
    apt-get install -y ttyd python3 python3-pip python3-venv curl ca-certificates && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Create a virtual environment and install dependencies
RUN python3 -m venv /venv
RUN /venv/bin/pip install --upgrade pip
RUN curl -o requirements.txt https://raw.githubusercontent.com/rabiuhadisalisu/xtx/main/requirements.txt
RUN /venv/bin/pip install --no-cache-dir -r requirements.txt

# Download the Python script
RUN curl -o script.py https://raw.githubusercontent.com/rabiuhadisalisu/xtx/main/qual.py

# Expose port 80
EXPOSE 80

# Start ttyd on port 80 to run the Python script within the virtual environment
CMD ["ttyd", "-i", "0.0.0.0", "-p", "80", "/venv/bin/python3", "/app/script.py"]
