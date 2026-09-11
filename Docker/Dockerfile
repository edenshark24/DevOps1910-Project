# Use official Python runtime as base image
FROM python:3.11-slim

# Set working directory in the container
WORKDIR /app

# Copy requirements file
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY app.py .

# Create a non-root user and switch to it
RUN adduser --disabled-password --no-create-home flaskuser
USER flaskuser

# Expose port 5000
EXPOSE 5000

# Command to run the application
CMD ["python", "app.py"]
