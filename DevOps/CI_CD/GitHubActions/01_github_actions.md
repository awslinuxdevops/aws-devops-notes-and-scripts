1️⃣ How do you automate build and test on PRs?

Question:
"How would you automate build and test for a Node.js app on pull requests?"

Answer:

Use on: pull_request trigger.

Checkout code, set up Node.js, install dependencies, run tests.

Example YAML:

name: PR Build & Test
on:
  pull_request:
    branches: [ main ]
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
        with:
          node-version: 16
      - run: npm install
      - run: npm test


Tip:
"This ensures every PR is tested automatically before merging, improving code quality."

2️⃣ How do you deploy Docker images to AWS using GitHub Actions?

Answer:

Use AWS credentials stored in GitHub secrets.

Login to ECR, build Docker image, push, then optionally deploy to ECS/EKS.

Example YAML:

name: Docker CI/CD
on:
  push:
    branches: [ main ]
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Login to AWS ECR
        run: |
          aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin ${{ secrets.AWS_ECR_REGISTRY }}
      - name: Build and Push Docker Image
        run: |
          docker build -t myapp:${{ github.sha }} .
          docker tag myapp:${{ github.sha }} ${{ secrets.AWS_ECR_REGISTRY }}/myapp:${{ github.sha }}
          docker push ${{ secrets.AWS_ECR_REGISTRY }}/myapp:${{ github.sha }}


Tip:
"We tag images with the Git SHA to ensure unique builds and easy rollback."

3️⃣ How do you handle environment secrets?

Answer:

Store secrets in GitHub repository → Settings → Secrets → Actions.

Access in workflows using ${{ secrets.NAME }}.

Example:

- name: Deploy to AWS
  run: aws ecs update-service --cluster my-cluster --service my-service --force-new-deployment
  env:
    AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
    AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}


Tip:
"This avoids hardcoding sensitive credentials in workflow YAML."

4️⃣ How do you manage multiple branches or environments?

Answer:

Use branch-specific workflows or parameterized environment jobs.

Tag Docker images or deployments with branch names.

Example YAML (branch-specific build):

on:
  push:
    branches:
      - main
      - develop


Tip:
"This ensures each branch is independently tested and deployed."

5️⃣ How do you troubleshoot workflow failures?

Answer:

Check workflow run logs in GitHub Actions.

Verify environment setup, dependencies, secrets, or permissions.

Re-run failed jobs or adjust workflow steps.

Tip:
"We had a failure in ECR login due to expired secret; updating the secret in GitHub fixed the issue."

6️⃣ How do you implement a scheduled workflow?

Answer:

Use schedule with cron syntax.

Example YAML:

on:
  schedule:
    - cron: '0 0 * * *' # runs every day at midnight
jobs:
  nightly:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - run: echo "Running nightly tasks"


Tip:
"We used scheduled workflows to run nightly DB backups and automated tests."

7️⃣ How do you store and use artifacts in workflows?

Answer:

Use actions/upload-artifact and actions/download-artifact.

Example:

- name: Upload build artifacts
  uses: actions/upload-artifact@v3
  with:
    name: build-files
    path: build/


Tip:
"Artifacts allow QA or other jobs to access build outputs for verification."

8️⃣ How do you run tests across multiple Node versions (matrix builds)?

Answer:

Use matrix strategy to run parallel jobs.

Example YAML:

strategy:
  matrix:
    node-version: [14, 16]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
        with:
          node-version: ${{ matrix.node-version }}
      - run: npm install
      - run: npm test


Tip:
"Matrix builds save time by testing multiple environments simultaneously."

9️⃣ How do you handle failed deployments?

Answer:

Keep previous versions or artifacts.

Implement rollback steps in workflow.

Example snippet:

if: failure()
run: echo "Deployment failed, rolling back to previous version"


Tip:
"We always tag Docker images with SHA, so rollback is just redeploying the previous image."

10️⃣ How do you integrate GitHub Actions with Slack notifications?

Answer:

Use slackapi/slack-github-action and GitHub secrets.

Example:

- name: Slack Notification
  uses: slackapi/slack-github-action@v1
  with:
    channel-id: 'C1234567890'
    slack-message: 'Build completed successfully'
    slack-bot-token: ${{ secrets.SLACK_TOKEN }}


Tip:
"We notify devs automatically on build success or failure."

11️⃣ How do you cache dependencies to speed up builds?

Answer:

Use actions/cache for package managers like npm, Maven.

Example:

- name: Cache Node modules
  uses: actions/cache@v3
  with:
    path: ~/.npm
    key: ${{ runner.os }}-node-${{ hashFiles('**/package-lock.json') }}


Tip:
"Caching reduced build times from 15 minutes to 5 minutes in our Node.js workflows."

12️⃣ How do you trigger a workflow manually?

Answer:

Use workflow_dispatch trigger.

Example YAML:

on:
  workflow_dispatch:
    inputs:
      environment:
        description: 'Environment to deploy'
        required: true
        default: dev


Tip:
"Manual triggers are used for emergency deployments or special runs."

13️⃣ How do you implement approvals before production deployment?

Answer:

Use environments with required reviewers in GitHub.

Tip:
"Production deployments required approval from the team lead to ensure safe releases."

14️⃣ How do you manage secrets dynamically with AWS?

Answer:

Store in AWS Secrets Manager.

Fetch secrets via AWS CLI in workflow steps.

Example:

- name: Fetch secret
  run: |
    export DB_PASSWORD=$(aws secretsmanager get-secret-value --secret-id prod/db-pass --query SecretString --output text)

15️⃣ How do you handle multiple jobs in parallel?

Answer:

Define multiple jobs in workflow; jobs run in parallel by default.

Example:

jobs:
  build:
    runs-on: ubuntu-latest
    steps: ...
  test:
    runs-on: ubuntu-latest
    steps: ...


Tip:
"We split build, test, and lint into separate jobs to reduce workflow time."

16️⃣ How do you reuse workflow logic across multiple repos?

Answer:

Use Reusable Workflows with workflow_call.

Example:

on:
  workflow_call:
    inputs:
      environment:
        required: true
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps: ...


Tip:
"This avoids duplication and ensures consistent CI/CD logic across repos."

17️⃣ How do you rollback failed workflow artifacts or deployment?

Answer:

Tag Docker images with build SHA or version.

Redeploy previous stable artifact if failure detected.

Scenario:
"If deployment failed in staging, we redeployed the last stable image, avoiding downtime."

18️⃣ How do you integrate GitHub Actions with Terraform?

Answer:

Use Terraform GitHub Action to run plan and apply.

Example:

- name: Terraform Init & Apply
  uses: hashicorp/terraform-github-actions@v2
  with:
    tf_actions_version: 1.5.7
    working-directory: ./terraform


Tip:
"This enabled automated infrastructure provisioning during CI/CD pipelines."

19️⃣ How do you test workflows before merging?

Answer:

Use feature branches and pull_request triggers.

Run test workflows on forks or branches before merging.

20️⃣ How do you manage long-running workflows?

Answer:

Use jobs in parallel.

Use concurrency to avoid conflicts.

Example:

concurrency:
  group: deploy-${{ github.ref }}
  cancel-in-progress: true


Tip:
"This ensures only one deployment runs per branch at a time, avoiding resource conflicts."