# Django Application

# Base Image
FROM python:3.10-slim

# Create the working Directory
WORKDIR /app

# Copy requirements file
COPY requirements.txt .

# Install the dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the files from local to container
COPY . .


# Expose Port
EXPOSE 8000


# RUN the application
CMD ["gunicorn", "mysite.wsgi:application", "--bind", "0.0.0.0:8000"]


