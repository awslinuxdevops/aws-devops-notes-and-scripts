# 🧠 MAVEN COMPLETE NOTES (DevOps + Interview Focus)

---

## 🔹 1. What is Maven?

* **Maven** is a **build automation tool** mainly used for **Java projects**.
* It manages:

  * **Build** (compile → package)
  * **Dependencies**
  * **Testing**
  * **Deployment**
* It uses **POM (Project Object Model)** for configuration (`pom.xml`).

---

## 🔹 2. Why DevOps Engineers Must Know Maven

As a DevOps Engineer:

* You integrate Maven with **CI/CD tools** like Jenkins.
* You automate Java builds.
* You manage **artifacts** (JARs/WARs) and publish them to **Nexus/Artifactory**.
* You ensure the correct **dependency management** and **versioning**.

---

## 🔹 3. Maven Directory Structure

```
myapp/
├── pom.xml
└── src/
    ├── main/
    │   ├── java/
    │   └── resources/
    └── test/
        ├── java/
        └── resources/
```

---

## 🔹 4. POM.xml (Project Object Model)

Example:

```xml
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0
         http://maven.apache.org/xsd/maven-4.0.0.xsd">
  
  <modelVersion>4.0.0</modelVersion>

  <groupId>com.devops</groupId>
  <artifactId>myapp</artifactId>
  <version>1.0.0</version>
  <packaging>jar</packaging>

  <dependencies>
    <dependency>
      <groupId>org.springframework.boot</groupId>
      <artifactId>spring-boot-starter-web</artifactId>
      <version>2.7.3</version>
    </dependency>
  </dependencies>

  <build>
    <plugins>
      <plugin>
        <groupId>org.apache.maven.plugins</groupId>
        <artifactId>maven-compiler-plugin</artifactId>
        <version>3.8.1</version>
        <configuration>
          <source>11</source>
          <target>11</target>
        </configuration>
      </plugin>
    </plugins>
  </build>

</project>
```

---

## 🔹 5. Maven Phases / Lifecycle

Maven has **three main lifecycles**:

1. **clean** → removes target directory.
2. **default** → handles project build.
3. **site** → generates documentation.

### Build phases in default lifecycle:

| Phase    | Description                                     |
| -------- | ----------------------------------------------- |
| validate | Validate project structure                      |
| compile  | Compile the source code                         |
| test     | Run unit tests                                  |
| package  | Package compiled code (JAR/WAR)                 |
| verify   | Run checks                                      |
| install  | Install package to local repo                   |
| deploy   | Copy final package to remote repo (e.g., Nexus) |

---

## 🔹 6. Maven Repositories

| Type    | Location             | Description                                                                  |
| ------- | -------------------- | ---------------------------------------------------------------------------- |
| Local   | `~/.m2/repository`   | Developer’s local cache                                                      |
| Central | Maven’s default repo | [https://repo.maven.apache.org/maven2](https://repo.maven.apache.org/maven2) |
| Remote  | Nexus/Artifactory    | Used for internal builds                                                     |

---

## 🔹 7. Maven Commands (Most Common)

| Command                  | Description                                             |
| ------------------------ | ------------------------------------------------------- |
| `mvn clean`              | Deletes target directory                                |
| `mvn compile`            | Compiles source code                                    |
| `mvn test`               | Runs tests                                              |
| `mvn package`            | Builds JAR/WAR file                                     |
| `mvn install`            | Installs package into local repo                        |
| `mvn deploy`             | Deploys to remote repo                                  |
| `mvn site`               | Generates documentation                                 |
| `mvn dependency:tree`    | Shows dependency hierarchy                              |
| `mvn help:effective-pom` | Displays final pom with inheritance and active profiles |

---

## 🔹 8. Maven Settings File (`settings.xml`)

Path: `~/.m2/settings.xml`

Use it for:

* Proxy settings
* Repository credentials
* Profiles
* Mirrors

Example:

```xml
<settings>
  <servers>
    <server>
      <id>nexus</id>
      <username>admin</username>
      <password>admin123</password>
    </server>
  </servers>
</settings>
```

---

## 🔹 9. Integrating Maven with Jenkins

### Step 1: Install Maven on Jenkins

* Go to **Manage Jenkins → Global Tool Configuration**
* Under **Maven**, add a Maven installation or point to existing `/usr/share/maven`.

### Step 2: Create a Maven Job

1. New Item → *Maven Project*
2. Source Code Management → Git → add repo URL.
3. Build section → add:

   ```
   Goals: clean package
   ```

### Step 3: Post-build

* Archive artifacts (`target/*.jar`)
* Deploy to:

  * **Nexus** (`mvn deploy`)
  * **Tomcat** using Jenkins Deploy plugin.

---

## 🔹 10. Jenkinsfile Example for Maven Project

```groovy
pipeline {
    agent any

    tools {
        maven 'Maven3'
        jdk 'JDK11'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/yourrepo/java-app.git'
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Test') {
            steps {
                sh 'mvn test'
            }
        }

        stage('Deploy to Nexus') {
            steps {
                sh 'mvn deploy'
            }
        }
    }

    post {
        success {
            echo "Build & Deployment Successful"
        }
        failure {
            echo "Build Failed"
        }
    }
}
```

---

## 🔹 11. Real-Time Scenarios

### ✅ Scenario 1:

**Problem:** Jenkins build fails with `Could not resolve dependencies`.
**Reason:** Nexus credentials not configured in `settings.xml`.
**Fix:**
Add credentials in Jenkins → global credentials
and reference via Maven `settings.xml`.

---

### ✅ Scenario 2:

**Problem:** You want to deploy only stable builds to Nexus.
**Approach:**

* Add a conditional in Jenkinsfile:

  ```groovy
  when { branch 'main' }
  ```

  Only deploy on main branch.

---

### ✅ Scenario 3:

**Problem:** Need to version artifacts automatically (e.g., using Git commit ID)
**Fix:**
Use Maven build helper plugin:

```xml
<plugin>
  <groupId>org.codehaus.mojo</groupId>
  <artifactId>buildnumber-maven-plugin</artifactId>
  <version>1.4</version>
  <executions>
    <execution>
      <phase>validate</phase>
      <goals><goal>create</goal></goals>
    </execution>
  </executions>
</plugin>
```

---

## 🔹 12. Maven Interview Questions

### 🧩 Basic

1. What is Maven and how is it different from Ant?
2. What is the use of the POM.xml file?
3. What is the default location of the local repository?

### ⚙️ Technical

4. What is the difference between `mvn install` and `mvn deploy`?
5. How do you handle dependency conflicts in Maven?
6. What are Maven plugins? Examples?
7. What is the purpose of `settings.xml`?

### 🚀 Real-Time / Scenario-Based

8. Your Jenkins build fails with “target folder not found” — what could be the issue?
9. How do you publish Maven artifacts to Nexus in Jenkins?
10. How do you manage multi-module Maven projects?

---

## 🔹 13. Multi-Module Maven Project (Example)

**Parent POM**

```xml
<modules>
  <module>service1</module>
  <module>service2</module>
</modules>
```

Each submodule has its own `pom.xml`.
When you run `mvn clean install` at root, it builds all modules sequentially.

---

## 🔹 14. Maven + Nexus Integration

* In POM.xml:

  ```xml
  <distributionManagement>
    <repository>
      <id>nexus</id>
      <url>http://nexus.company.com/repository/releases/</url>
    </repository>
  </distributionManagement>
  ```
* In Jenkins `settings.xml` → credentials for `<id>nexus</id>`

---

## 🔹 15. Maven + Docker + Jenkins (Complete CI/CD Example)

1. Maven builds → `mvn clean package`
2. Jenkins Docker stage:

   ```groovy
   stage('Docker Build & Push') {
       steps {
           sh '''
             docker build -t myapp:${BUILD_NUMBER} .
             docker tag myapp:${BUILD_NUMBER} myrepo/myapp:${BUILD_NUMBER}
             docker push myrepo/myapp:${BUILD_NUMBER}
           '''
       }
   }
   ```
3. Deploy to Kubernetes using Helm or kubectl.

---

## 🔹 16. Maven Best Practices

✅ Keep dependencies version-controlled
✅ Use a corporate Nexus instead of Central
✅ Use parent POM for common configuration
✅ Use profiles for environment-specific builds
✅ Use Jenkins credentials binding for Nexus authentication

---
