# Use Playwright's official Python base image
FROM mcr.microsoft.com/playwright/python:v1.54.0-jammy

# Avoid interactive apt prompts during CI builds
ENV DEBIAN_FRONTEND=noninteractive \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Set the working directory
WORKDIR /app

# Copy apt package list
COPY apt.txt .

# Install only required apt packages
RUN apt-get update && \
    xargs -a apt.txt apt-get install -y --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

# Copy requirements first for caching
COPY requirements.txt .

# Upgrade pip + install deps
RUN pip install --upgrade pip setuptools wheel && \
    pip install --no-cache-dir -r requirements.txt

# Copy the rest of your source code
COPY . .

# Expose Flask + Xpra ports
EXPOSE 8080
EXPOSE 10000

# Start the app
CMD ["python3", "app/main.py"]

