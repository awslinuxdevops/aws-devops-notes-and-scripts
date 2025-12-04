# Dockerfile for Node JS applicaiton
# Base Image
FROM node:18-alpine

# Create app directory
WORKDIR /app

# Install dependencies First
COPY package*.json ./

RUN npm install --production

# COPY entire project
COPY . .

# EXPOSE Port
EXPOSE 3000

# Start the app
CMD ["ndoe", "server.js"]
