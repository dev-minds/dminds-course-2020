#!/usr/bin/env groovy
/**
  ***** Dminds Devops ToolChain *****
  Documentation: https://
  Status: Continouse Improvement 
https://groovy-lang.org/semantics.html
*/
import org.jenkinsci.plugins.pipeline.modeldefinition.Utils

node {
    checkout scm
    deleteDir()
}

def seperator60 = '\u2739' * 60
def seperator20 = '\u2739' * 20
def seperator30 = '\u2739' * 30

node() {
    stage('fetch repo') {
        echo "${seperator60}\n${seperator20} Checking out Source Repo \n${seperator60}"
        deleteDir()
        checkout scm
    }

    stage('TestBuckets') {
        echo "${seperator60}\n${seperator20} Stage two \n${seperator60}"
        withCredentials([[$class: 'AmazonWebServicesCredentialsBinding',
            credentialsId: "admin_centrale",
            accessKeyVariable: 'AWS_ACCESS_KEY_ID', 
            secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
        ]]) {
            wrap([$class: 'AnsiColorBuildWrapper', 'colorMapName': 'xterm']){
                    dir("./lesson_13/infra-cicd/ami_build"){
                        sh """
                            packer build fe.json
                        """
                    }                
            }
        }

    }

    stage("DeployToSandbox") {
        input 'Deploy to sandbox ?'
    }
}