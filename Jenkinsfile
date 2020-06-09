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

def runParallel = true
def buildStages

node() {
    stage('fetch repo') {
        echo "${seperator60}\n${seperator20} Checking out Source Repo \n${seperator60}"
        deleteDir()
        checkout scm
    }

    stage('Mangement VPC') {
        echo "${seperator60}\n${seperator20} Building VPCs And Management Env \n${seperator60}"
        withCredentials([[$class: 'AmazonWebServicesCredentialsBinding',
            credentialsId: "admin_centrale",
            accessKeyVariable: 'AWS_ACCESS_KEY_ID', 
            secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
        ]]) {
            wrap([$class: 'AnsiColorBuildWrapper', 'colorMapName': 'xterm']){
                    dir("./lesson_13/infra-cicd/aws_centrale/"){
                        sh """
                            terraform init 
                            terraform fmt 
                            terraform validate
                            input 'Deploy to sandbox ?'
                            terraform apply -auto-approve
                        """
                    } 
            }
        }
    }

    stage('SandBox VPC') {
        echo "${seperator60}\n${seperator20} Building VPCs And Management Env \n${seperator60}"
        withCredentials([[$class: 'AmazonWebServicesCredentialsBinding',
            credentialsId: "admin_sandbox",
            accessKeyVariable: 'AWS_ACCESS_KEY_ID', 
            secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
        ]]) {
            wrap([$class: 'AnsiColorBuildWrapper', 'colorMapName': 'xterm']){
                    dir("./lesson_13/infra-cicd/aws_sandbox/"){
                        sh """
                            terraform init 
                            terraform fmt 
                            terraform validate
                            input 'Deploy to sandbox ?'
                            terraform apply -auto-approve
                        """
                    }                
            }
        }
    }

    stage('Preprod VPC') {
        echo "${seperator60}\n${seperator20} Building VPCs And Management Env \n${seperator60}"
        withCredentials([[$class: 'AmazonWebServicesCredentialsBinding',
            credentialsId: "admin_preprod",
            accessKeyVariable: 'AWS_ACCESS_KEY_ID', 
            secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
        ]]) {
            wrap([$class: 'AnsiColorBuildWrapper', 'colorMapName': 'xterm']){
                    dir("./lesson_13/infra-cicd/aws_preprod/"){
                        sh """
                            terraform init
                            terraform fmt 
                            terraform validate
                            input 'Deploy to sandbox ?'
                            terraform apply -auto-approve
                        """
                    }                
            }
        }
    }

    stage("DeployToSandbox") {
        input 'Create AMIs on sandbox ?'
    }

    stage('SandBox FE & BE AMIs') {
        echo "${seperator60}\n${seperator20} Building both frontend and backend amis \n${seperator60}"
        withCredentials([[$class: 'AmazonWebServicesCredentialsBinding',
            credentialsId: "admin_centrale",
            accessKeyVariable: 'AWS_ACCESS_KEY_ID', 
            secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
        ]]) {
            wrap([$class: 'AnsiColorBuildWrapper', 'colorMapName': 'xterm']){
                    dir("./lesson_13/infra-cicd/ami_build"){
                        sh """
                            packer build fe.json ; packer build be.json
                        """
                    }                
            }
        }

    }

    stage("DeployToPreprod") {
        input 'Deploy to preprod?'
    }

    stage('SandBox FE & BE AMIs') {
        echo "${seperator60}\n${seperator20} Building both frontend and backend amis \n${seperator60}"
        withCredentials([[$class: 'AmazonWebServicesCredentialsBinding',
            credentialsId: "admin_centrale",
            accessKeyVariable: 'AWS_ACCESS_KEY_ID', 
            secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
        ]]) {
            wrap([$class: 'AnsiColorBuildWrapper', 'colorMapName': 'xterm']){
                    dir("./lesson_13/infra-cicd/ami_build"){
                        sh """
                            packer build fe.json ; packer build be.json
                        """
                    }                
            }
        }
    }

    stage('Preprod FE & BE AMIs') {
        echo "${seperator60}\n${seperator20} Building both frontend and backend amis \n${seperator60}"
        withCredentials([[$class: 'AmazonWebServicesCredentialsBinding',
            credentialsId: "admin_centrale",
            accessKeyVariable: 'AWS_ACCESS_KEY_ID', 
            secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
        ]]) {
            wrap([$class: 'AnsiColorBuildWrapper', 'colorMapName': 'xterm']){
                    dir("./lesson_13/infra-cicd/ami_build"){
                        sh """
                            packer build fe.json ; packer build be.json
                        """
                    }                
            }
        }
    }
}