# Python Dockerfile

# Base Image
FROM python:3-10-slim


# Create app directory
WORKDIR /app


# Copy requirements first
COPY requirements.txt .

# Install necessary dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy application files
COPY . .


# Expose port
EXPOSE 8080


# Start the application
CMD ["python","app.py"]