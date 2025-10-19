// vars/buildApp.groovy
def call(String appName) {
    stage("Build - ${appName}") {
        echo "Building application: ${appName}"
        sh "mvn clean package -DskipTests"
    }
}
