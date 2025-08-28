# Use Playwright's official Python base image
FROM mcr.microsoft.com/playwright/python:v1.54.0-jammy

# Avoid interactive apt prompts during CI builds
ENV DEBIAN_FRONTEND=noninteractive \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app

# (Optional) Install OS packages here if you need them
# Install apt dependencies from file
COPY apt-packages.txt .
RUN apt-get update && xargs -a apt-packages.txt apt-get install -y --no-install-recommends \
  && rm -rf /var/lib/apt/lists/*

# Install Python deps first (better layer caching)
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Expose the Flask/Xpra port
EXPOSE 8000
EXPOSE 10000
