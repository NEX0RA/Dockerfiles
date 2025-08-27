# Use Playwright's official Python base image
FROM mcr.microsoft.com/playwright/python:v1.54.0-jammy

# Install xpra + deps
RUN apt-get update && \
    apt-get install -y xpra xvfb x11-utils x11-xserver-utils ffmpeg \
                       libgl1-mesa-dri libgl1-mesa-glx libegl1-mesa && \
    rm -rf /var/lib/apt/lists/*

# Set the virtual display environment variable for Xvfb/Xpra
ENV DISPLAY=:99

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Expose Flask + Xpra ports
EXPOSE 8080
EXPOSE 10000
