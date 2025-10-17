# 🧩 Complete Maven Notes for DevOps & Jenkins Integration

---

## 1. Maven Overview

### 🔹 What is Maven?

Maven is a **build automation and dependency management tool** used primarily for Java projects. It simplifies the build process — compile, package, test, and deploy — by following a standard lifecycle.

### 🔹 Key Benefits

* **Standardization:** All projects have the same directory and lifecycle structure.
* **Dependency Management:** Automatically downloads and manages libraries from repositories.
* **Integration:** Works well with Jenkins, Nexus, Artifactory, and other CI/CD tools.

### 🔹 Maven Architecture

* **POM (Project Object Model)** → Configuration file (`pom.xml`)
* **Repositories:**

  * Local: `~/.m2/repository`
  * Central: Maven Central Repository
  * Remote: Nexus, JFrog Artifactory, AWS CodeArtifact, etc.
* **Lifecycle Phases:**

  * `validate`, `compile`, `test`, `package`, `verify`, `install`, `deploy`

### 🔹 Maven Lifecycle Flow Example

```bash
mvn clean package
```

➡️ Cleans target directory, compiles source code, runs tests, and packages output (JAR/WAR).

---

## 2. Maven Core Concepts

### 📘 pom.xml Example

```xml
<project>
  <modelVersion>4.0.0</modelVersion>
  <groupId>com.example</groupId>
  <artifactId>demo-app</artifactId>
  <version>1.0.0</version>
  <packaging>jar</packaging>

  <dependencies>
    <dependency>
      <groupId>junit</groupId>
      <artifactId>junit</artifactId>
      <version>4.13.2</version>
      <scope>test</scope>
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

### ⚙️ settings.xml (for credentials)

```xml
<servers>
  <server>
    <id>nexus</id>
    <username>admin</username>
    <password>admin123</password>
  </server>
</servers>
```

### 📦 Repository Types

| Type    | Example                                | Description             |
| ------- | -------------------------------------- | ----------------------- |
| Local   | `~/.m2/repository`                     | Cached dependencies     |
| Central | `https://repo.maven.apache.org/maven2` | Global public repo      |
| Remote  | Nexus / Artifactory                    | Private enterprise repo |

---

## 3. Common Maven Commands

| Command               | Description                                  |
| --------------------- | -------------------------------------------- |
| `mvn clean`           | Cleans target directory                      |
| `mvn compile`         | Compiles the project                         |
| `mvn test`            | Runs test cases                              |
| `mvn package`         | Packages code into JAR/WAR                   |
| `mvn install`         | Installs artifact into local repo            |
| `mvn deploy`          | Deploys artifact to remote repo (like Nexus) |
| `mvn dependency:tree` | Displays dependency hierarchy                |

---

## 4. Jenkins Integration with Maven

### 📘 Jenkins Setup Steps

1. Install **Maven** and **JDK** in Jenkins (Manage Jenkins → Global Tool Configuration)
2. Create a **Jenkins Pipeline** or **Freestyle job**
3. Add build step → *Invoke top-level Maven targets*
4. Target: `clean install`

### 📜 Jenkins Pipeline Example

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
        git branch: 'main', url: 'https://github.com/awslinuxdevops/demo-app.git'
      }
    }
    stage('Build') {
      steps {
        sh 'mvn clean package'
      }
    }
    stage('Deploy to Nexus') {
      steps {
        sh 'mvn deploy -s settings.xml'
      }
    }
  }
}
```

---

## 5. Real-Time & Scenario-Based Maven Interview Q&A

### 🔹 Q1. What is Maven and why is it used?

**Answer (Structure for Interview):**

> Maven is a build automation and dependency management tool mainly used for Java-based projects. It helps automate the compilation, testing, packaging, and deployment process using a standard lifecycle. The main advantage is dependency management — instead of manually adding JARs, Maven downloads them automatically from repositories.

**Command Example:**

```bash
mvn clean package
```

**Use Case:**
Whenever the developer commits code, Jenkins runs the Maven build (`mvn clean package`) to create a JAR/WAR file automatically.

---

### 🔹 Q2. What are the main phases of Maven build lifecycle?

**Answer:**

> Maven has three main lifecycles: `clean`, `default`, and `site`. Each lifecycle has multiple phases. For example, the default lifecycle includes validate → compile → test → package → verify → install → deploy. We usually use `mvn clean package` or `mvn clean install` in CI pipelines.

**Command Example:**

```bash
mvn clean install
```

* `clean` → deletes target folder
* `install` → installs artifact to local `.m2` repository

---

### 🔹 Q3. Difference between `mvn install` and `mvn deploy`

**Answer:**

> `mvn install` copies the artifact to the **local repository** (~/.m2).
> `mvn deploy` pushes the artifact to a **remote repository** like Nexus, Artifactory, or AWS CodeArtifact.

**Command Example:**

```bash
mvn deploy
```

**Interview Tip:**
Say that in CI/CD, Jenkins uses `mvn deploy` during the release stage to publish the build to a shared repository.

---

### 🔹 Q4. What is the difference between `pom.xml` and `settings.xml`?

**Answer:**

> `pom.xml` belongs to the project — it defines dependencies, plugins, and build instructions.
> `settings.xml` is a Maven-level configuration file used to store credentials, proxy details, and repository information.

**Example paths:**

```
pom.xml → in project root
settings.xml → ~/.m2/settings.xml
```

**Interview Add-on:**

> In Jenkins pipelines, we keep credentials like Nexus username/password in `settings.xml` and reference them in the Maven build.

---

### 🔹 Q5. How do you handle dependency conflicts in Maven?

**Answer:**

> Dependency conflict occurs when two libraries depend on different versions of the same artifact. We can identify conflicts using `mvn dependency:tree` command and use the `<dependencyManagement>` section to fix the version.

**Command Example:**

```bash
mvn dependency:tree
```

**Interview Tip:**

> In real-time, I once faced a Spring dependency conflict, and I resolved it by forcing the required version in the parent POM using `dependencyManagement`.

---

### 🔹 Q6. What are Maven plugins and why are they important?

**Answer:**

> Plugins add functionality to Maven — like compiling code, packaging WARs, running tests, or deploying builds. For example, the **maven-compiler-plugin** compiles Java code, and the **maven-surefire-plugin** runs unit tests.

**Example:**

```xml
<plugin>
  <groupId>org.apache.maven.plugins</groupId>
  <artifactId>maven-compiler-plugin</artifactId>
  <version>3.8.1</version>
</plugin>
```

**Interview Tip:**

> Every phase in Maven lifecycle is tied to a plugin — e.g., `mvn test` internally runs the surefire plugin.

---

### 🔹 Q7. How do you skip tests during Maven build?

**Answer:**

> Sometimes we skip unit tests to speed up deployment or when test cases are not stable. We can skip tests using `-DskipTests` or `-Dmaven.test.skip=true`.

**Command Examples:**

```bash
mvn clean package -DskipTests
mvn clean install -Dmaven.test.skip=true
```

**Interview Add-on:**

> In production CI pipelines, we only skip tests after approval, usually for hotfix releases.

---

### 🔹 Q8. How to clean and rebuild a project in Maven?

**Answer:**

> The `clean` phase removes the previous build artifacts (target folder), and `package` rebuilds the project. We usually combine both.

**Command Example:**

```bash
mvn clean package
```

**Interview Add-on:**

> In Jenkins, we often use this during the build stage to ensure a fresh build every time.

---

### 🔹 Q9. How do you integrate Maven with Jenkins?

**Answer:**

> Jenkins uses the Maven plugin to trigger builds automatically. In the pipeline, we define build stages with commands like `mvn clean package`. Jenkins downloads dependencies, runs tests, and packages artifacts, then pushes them to Nexus or ECR.

**Jenkinsfile Example:**

```groovy
stage('Build') {
    steps {
        sh 'mvn clean package'
    }
}
```

**Interview Add-on:**

> I configured Maven globally in Jenkins under “Global Tool Configuration” and used environment variables like `$MAVEN_HOME` in pipelines.

---

### 🔹 Q10. How do you deploy Maven artifacts to Nexus or Artifactory?

**Answer:**

> You define the remote repository in `pom.xml` under `<distributionManagement>` and add credentials in `settings.xml`. Then you use the `mvn deploy` command to push artifacts.

**Command Example:**

```bash
mvn deploy
```

**Interview Add-on:**

> In Jenkins, I used a post-build step with `mvn deploy` to publish artifacts to Nexus, and we used Jenkins credentials binding for authentication.

---

### 🔹 Q11. How do you manage multi-module Maven projects?

**Answer:**

> Multi-module projects allow building multiple related services with one command. The parent `pom.xml` defines common plugins and dependencies. All child modules are defined under the `<modules>` tag.

**Command Example:**

```bash
mvn clean install
```

**Interview Add-on:**

> I used this in a microservice setup — running `mvn install` at root builds all submodules sequentially.

---

### 🔹 Q12. What’s the difference between local, central, and remote repositories?

**Answer:**

> Local repository → present on the developer’s machine (~/.m2).
> Central repository → Maven’s public repo (downloads dependencies).
> Remote repository → internal repo like Nexus, CodeArtifact, or Artifactory.

**Interview Add-on:**

> In CI/CD, builds first check the local cache, then the remote repository, to speed up dependency resolution.

---

### 🔹 Q13. Real-Time Scenario: Maven Build Failing in Jenkins

**Question:**
Your Jenkins Maven build fails with “Could not resolve dependencies”. What will you check?

**Answer:**

1. Check if **Nexus/remote repo credentials** are correct in `settings.xml`.
2. Verify if **network/proxy** allows access to Maven Central.
3. Try running the command manually:

   ```bash
   mvn clean compile -X
   ```

   (the `-X` flag gives detailed logs)
4. If internal repo used, check Nexus availability or artifact path.

**Interview Tip:**

> I’d start by checking credentials and network connectivity because most Maven dependency failures are due to authentication or proxy configuration issues.

---

### 🔹 Q14. Real-Time Scenario: Slow Maven Builds

**Question:**
Maven builds are slow in Jenkins. What steps would you take?

**Answer:**

> I’d first enable Maven caching on Jenkins to reuse the `.m2` repository between builds.
> Second, I’d use a local Nexus mirror to avoid downloading from Maven Central every time.

**Command Example (Maven mirror in settings.xml):**

```xml
<mirrors>
  <mirror>
    <id>nexus</id>
    <url>http://nexus.company.com/repository/maven-public/</url>
    <mirrorOf>*</mirrorOf>
  </mirror>
</mirrors>
```

**Interview Add-on:**

> After caching `.m2`, our build time reduced from 6 minutes to 2 minutes — a real-time performance improvement.

---

### 🔹 Q15. Real-Time Scenario: Build Number or Versioning

**Question:**
How do you manage version numbers in Maven automatically?

**Answer:**

> We use the `buildnumber-maven-plugin` to append build numbers or Git commit IDs automatically.
> This helps track which Jenkins build created the artifact.

**Command Example:**

```bash
mvn buildnumber:create
```

**Interview Add-on:**

> I’ve used this plugin in CI pipelines to generate unique versioned artifacts like `myapp-1.0.${BUILD_NUMBER}.jar`.

---

### 🔹 Q16. Real-Time Scenario: Artifact Promotion

**Question:**
How do you promote artifacts between environments (dev → QA → prod)?

**Answer:**

> We use Maven + Jenkins + Nexus integration.
> The artifact built in dev is tagged and pushed to Nexus.
> QA and Prod Jenkins pipelines then **pull the same version** from Nexus for deployment — ensuring consistency.

**Interview Add-on:**

> This avoids rebuilding code for each environment — we just promote the tested artifact.

---

## 6. Maven Artifact Repository vs AWS ECR

| Feature     | **AWS ECR**             | **Nexus Repository**                        |
| ----------- | ----------------------- | ------------------------------------------- |
| Purpose     | Stores Docker images    | Stores build artifacts (JAR/WAR, npm, etc.) |
| Example     | `docker push <ECR_URL>` | `mvn deploy`                                |
| Integration | ECS, EKS                | Jenkins, Maven                              |
| Managed by  | AWS                     | Self-hosted or Sonatype                     |

**Interview Explanation:**

> "ECR is used for container images, while Nexus is used for storing Maven artifacts. In CI/CD pipelines, Maven builds generate artifacts which are pushed to Nexus, then Docker builds push container images to ECR for deployment."

---

## 7. Appendix: Full Technical & Scenario Q&A (Condensed Answers You Can Memorize)

1. **What is Maven?** — Build automation & dependency manager for Java. Use: `mvn clean package`.
2. **Maven lifecycles?** — clean, default, site. Default phases: validate → compile → test → package → verify → install → deploy.
3. **install vs deploy?** — install = local repo, deploy = remote repo.
4. **pom.xml vs settings.xml?** — pom = project; settings = user/maven config (credentials).
5. **Dependency conflict?** — Use `mvn dependency:tree` and `dependencyManagement` to force versions.
6. **Plugins?** — e.g., maven-compiler-plugin, surefire-plugin.
7. **Skip tests?** — `-DskipTests` or `-Dmaven.test.skip=true`.
8. **Clean rebuild?** — `mvn clean package`.
9. **Jenkins integration?** — Use `mvn clean package` in pipeline, configure Maven in Jenkins tools.
10. **Deploy to Nexus?** — Configure `<distributionManagement>` and `settings.xml`, then `mvn deploy`.
11. **Multi-module?** — Parent POM with `<modules>...</modules>`, run `mvn clean install` at root.
12. **Repositories?** — Local (`~/.m2`), Central, Remote (Nexus).
13. **Dependency failing in Jenkins?** — Check credentials, network, run `mvn -X`.
14. **Slow builds?** — Cache `.m2`, use Nexus mirror.
15. **Versioning?** — Use buildnumber-maven-plugin or CI build numbers.
16. **Artifact promotion?** — Push once to Nexus and promote the same artifact across environments.

---

✅ Document updated with full Q&A (16 items), commands, and interview-ready phrasing.

Would you like me to now add **Maven + SonarQube** integration for code quality in Jenkins? (I can prepare the Jenkinsfile snippet and example `pom.xml` plugin configuration.)
