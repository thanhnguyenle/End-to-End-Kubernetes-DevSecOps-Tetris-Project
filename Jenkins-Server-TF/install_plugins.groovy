import jenkins.model.*
import hudson.model.*

def inst = Jenkins.getInstance()
def pm = inst.getPluginManager()
def uc = inst.getUpdateCenter()

uc.updateAllSites()

def plugins = [
    "aws-credentials",
    "pipeline-aws", 
    "docker-plugin",
    "docker-commons",
    "docker-workflow",
    "docker-java-api",
    "docker-build-step",
    "adoptopenjdk",
    "nodejs",
    "dependency-check-jenkins-plugin",
    "sonar"
]

plugins.each { pluginName ->
    if (!pm.getPlugin(pluginName)) {
        def plugin = uc.getPlugin(pluginName)
        if (plugin) {
            plugin.deploy()
            println "Installing: ${pluginName}"
        } else {
            println "NOT FOUND in update center: ${pluginName}"
        }
    } else {
        println "Already installed: ${pluginName}"
    }
}