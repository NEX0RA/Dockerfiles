# Use a small base image
FROM python:3.12-slim

# Avoid interactive apt prompts during CI builds
ENV DEBIAN_FRONTEND=noninteractive \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app

# (Optional) Install OS packages here if you need them
# RUN apt-get update && apt-get install -y --no-install-recommends \
#     curl gcc build-essential \
#  && rm -rf /var/lib/apt/lists/*

# Install Python deps first (better layer caching)
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the app
COPY app ./app

# Expose the Flask port
EXPOSE 8000

# Run the app
CMD ["python", "app/main.py"]

