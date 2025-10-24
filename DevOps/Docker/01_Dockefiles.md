🟩 1️⃣ Node.js Dockerfile
📄 Dockerfile
FROM node:18-alpine
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 3000
CMD ["npm", "start"]

| Step                    | Description                                |
| ----------------------- | ------------------------------------------ |
| `FROM node:18-alpine`   | Use lightweight Node.js base image         |
| `WORKDIR /app`          | Set working directory inside the container |
| `COPY package*.json ./` | Copy dependency files                      |
| `RUN npm install`       | Install app dependencies                   |
| `COPY . .`              | Copy rest of source code                   |
| `EXPOSE 3000`           | Open port 3000                             |
| `CMD ["npm", "start"]`  | Run Node.js application                    |

▶️ Build & Run
docker build -t node-app .
docker run -p 3000:3000 node-app

☕ 2️⃣ Java (Spring Boot) Dockerfile
📄 Dockerfile
FROM openjdk:17-jdk-alpine
WORKDIR /app
COPY target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]

| Step                                     | Description                |
| ---------------------------------------- | -------------------------- |
| `FROM openjdk:17-jdk-alpine`             | Base image for Java        |
| `WORKDIR /app`                           | Create and switch to /app  |
| `COPY target/*.jar app.jar`              | Copy the compiled JAR file |
| `EXPOSE 8080`                            | Expose port 8080           |
| `ENTRYPOINT ["java", "-jar", "app.jar"]` | Run Spring Boot app        |

▶️ Build & Run
mvn clean package
docker build -t springboot-app .
docker run -p 8080:8080 springboot-app

🐍 3️⃣ Python (Flask / FastAPI)
📄 Dockerfile
FROM python:3.11-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
EXPOSE 5000
CMD ["python", "app.py"]

| Step                       | Description                     |
| -------------------------- | ------------------------------- |
| `FROM python:3.11-slim`    | Lightweight Python base image   |
| `WORKDIR /app`             | App directory                   |
| `COPY requirements.txt .`  | Copy dependency list            |
| `RUN pip install ...`      | Install dependencies            |
| `COPY . .`                 | Copy app code                   |
| `EXPOSE 5000`              | Open Flask/FastAPI default port |
| `CMD ["python", "app.py"]` | Start the app                   |

▶️ Build & Run
docker build -t python-app .
docker run -p 5000:5000 python-app

⚙️ 4️⃣ Go (Golang)
📄 Dockerfile
FROM golang:1.22-alpine AS build
WORKDIR /app
COPY . .
RUN go mod download
RUN go build -o main .

FROM alpine:latest
WORKDIR /app
COPY --from=build /app/main .
EXPOSE 8080
CMD ["./main"]

| Step              | Description                                              |
| ----------------- | -------------------------------------------------------- |
| Multi-stage build | First compiles Go app, then copies binary to final image |
| `go mod download` | Downloads dependencies                                   |
| `go build`        | Compiles executable                                      |
| `FROM alpine`     | Lightweight final runtime                                |
| `CMD ["./main"]`  | Runs the compiled binary                                 |

▶️ Build & Run
docker build -t go-app .
docker run -p 8080:8080 go-app

🎨 5️⃣ React (Frontend)
📄 Dockerfile
# Stage 1: Build React app
FROM node:18-alpine as build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Stage 2: Serve with Nginx
FROM nginx:stable-alpine
COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

| Step              | Description                                              |
| ----------------- | -------------------------------------------------------- |
| Multi-stage build | First compiles Go app, then copies binary to final image |
| `go mod download` | Downloads dependencies                                   |
| `go build`        | Compiles executable                                      |
| `FROM alpine`     | Lightweight final runtime                                |
| `CMD ["./main"]`  | Runs the compiled binary                                 |

▶️ Build & Run
docker build -t react-app .
docker run -p 80:80 react-app

| Tip                      | Description                                          |
| ------------------------ | ---------------------------------------------------- |
| 🧱 Use `.dockerignore`   | Exclude files like `node_modules`, `.git`, `target/` |
| ⚡ Use Alpine images      | Lightweight and faster builds                        |
| 🔐 Avoid running as root | Add non-root user for production                     |
| 🧰 Multi-stage builds    | Reduce image size by separating build and runtime    |
| 🧪 Test locally          | Always run and test before pushing to registry       |

🧩 Sample .dockerignore
```
node_modules
target
.git
.gitignore
Dockerfile
docker-compose.yml
logs
```
🏁 How to Clean Docker Environment
```
# Remove all stopped containers
docker container prune -f

# Remove all unused images
docker image prune -a -f

# Remove unused volumes
docker volume prune -f
```