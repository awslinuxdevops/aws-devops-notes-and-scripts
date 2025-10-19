// vars/dockerBuildPush.groovy
def call(String appName, String dockerRepo, String tag = "latest") {
    stage("Docker Build & Push - ${appName}") {
        echo "Building Docker image for ${appName}"
        sh "docker build -t ${dockerRepo}/${appName}:${tag} ."
        echo "Pushing Docker image to repo"
        sh "docker push ${dockerRepo}/${appName}:${tag}"
    }
}
