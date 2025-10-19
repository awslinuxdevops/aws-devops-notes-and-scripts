# Jenkins Notes

**⚙️ What is Jenkins?**

- **Jenkins** is an **open-source automation server** used to **build, test, and deploy applications automatically** as part of a **Continuous Integration (CI)** and **Continuous Deployment (CD)** process.

It was originally developed by Kohsuke Kawaguchi and written in Java.

```
Developer (Git Push)
        ↓
   GitHub Webhook
        ↓
   Jenkins Master
        ↓
 Jenkins Agents (Build/Test/Deploy)
        ↓
 Docker → ECR → Kubernetes / EC2
        ↓
 Notification → Slack / Email

```

**Example Jenkinsfile (Declarative Pipeline)
```
pipeline {
  agent any

  stages {
    stage('Checkout') {
      steps {
        git 'https://github.com/gurumurthy/app.git'
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

    stage('Deploy') {
      steps {
        sh 'scp target/app.jar ec2-user@myserver:/apps/'
        sh 'ssh ec2-user@myserver "systemctl restart myapp"'
      }
    }
  }

  post {
    success {
      echo "✅ Deployment successful!"
    }
    failure {
      echo "❌ Deployment failed!"
    }
  }
}
```

| Component                       | Description                                                                                   |
| ------------------------------- | --------------------------------------------------------------------------------------------- |
| **Jenkins Master / Controller** | Main Jenkins server that manages jobs, schedules builds, monitors agents, and provides UI.    |
| **Jenkins Agent / Node**        | Executes the actual build, test, or deployment steps.                                         |
| **Jenkinsfile**                 | “Pipeline as Code” file that defines all stages (Build → Test → Deploy).                      |
| **Plugins**                     | Extend Jenkins functionality — integration with Git, Docker, AWS, K8s, SonarQube, Slack, etc. |


**What is agent any in Jenkins Pipeline, and how do you use nodes?**

- In Jenkins declarative pipelines, the agent directive tells Jenkins where the pipeline or stage should run.
When we specify agent any, Jenkins will execute the pipeline on any available agent or node.
If I want to target a specific agent, I use a label like agent `{ label 'docker-node' }.`

- In older scripted pipelines, we use `node('label-name') { ... }` blocks to define where the job should run.
- In my project, for example, I run build stages on a Maven node and deployment stages on a Kubernetes node by defining different agent labels.

**What is the purpose of the /vars folder in Jenkins?**

- In Jenkins, the `/vars` folder is part of a shared library that stores global Groovy scripts and reusable pipeline steps.
- Each .groovy file inside /vars becomes a callable method in Jenkins pipelines.
This helps us maintain clean and modular pipelines by keeping common logic (like build, test, deploy, and notification steps) reusable across multiple Jenkinsfiles.

- For example, I keep functions like buildApp.groovy or deployToAWS.groovy inside /vars, and call them directly in pipelines using buildApp() or deployToAWS().

**Points to Remember:**

| Point                        | Description                                                   |
| ---------------------------- | ------------------------------------------------------------- |
| 🔹 `/vars` folder            | For global Groovy scripts (each file = one callable function) |
| 🔹 File name = Function name | `vars/deployApp.groovy` → usable as `deployApp()`             |
| 🔹 Used with `@Library()`    | Import shared library in Jenkinsfile                          |
| 🔹 Maintains reusability     | Avoids duplicate code in many pipelines                       |
| 🔹 Stored in Git             | Jenkins pulls the shared library from Git repo                |


**Structure in Git Repository**

```
jenkins-shared-library/
│
├── vars/
│   ├── buildApp.groovy
│   ├── deployToAWS.groovy
│   └── notifySlack.groovy
│
├── resources/
│   ├── templates/
│   └── configs/
│
└── src/
    └── org/devops/
        └── utils.groovy
```

**Example:** `vars/buildApp.groovy`
```
def call(String appName) {
    stage('Build') {
        echo "Building ${appName}..."
        sh 'mvn clean package -DskipTests'
    }
}
-------------------------------------------
// How to Use it in Jenkinsfile

@Library('jenkins-shared-library') _
pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                buildApp('inventory-service')
            }
        }
    }
}

// 👉 Now, buildApp() is coming from the /vars/buildApp.groovy file in your Git repo.

```
