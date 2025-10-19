// vars/notifySlack.groovy
def call(String channel, String message, boolean success = true) {
    stage("Notify Slack") {
        def color = success ? "#36a64f" : "#ff0000"
        slackSend(channel: channel, color: color, message: message)
    }
}
