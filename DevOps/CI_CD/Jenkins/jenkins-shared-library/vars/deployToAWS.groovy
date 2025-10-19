// vars/deployToAWS.groovy
def call(String appName, String env, String instanceIp) {
    stage("Deploy - ${appName} to ${env}") {
        echo "Deploying ${appName} to EC2 instance: ${instanceIp}"
        sh """
            scp target/${appName}.jar ec2-user@${instanceIp}:/apps/
            ssh ec2-user@${instanceIp} 'systemctl stop ${appName} || true'
            ssh ec2-user@${instanceIp} 'mv /apps/${appName}.jar /apps/${appName}-backup.jar || true'
            ssh ec2-user@${instanceIp} 'systemctl start ${appName}'
        """
    }
}
