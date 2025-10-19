// vars/runTests.groovy
def call(String appName, boolean runUnitTests = true, boolean runIntegrationTests = false) {
    stage("Test - ${appName}") {
        if (runUnitTests) {
            echo "Running Unit Tests for ${appName}"
            sh "mvn test"
        }
        if (runIntegrationTests) {
            echo "Running Integration Tests for ${appName}"
            sh "mvn verify -Pintegration"
        }
    }
}
