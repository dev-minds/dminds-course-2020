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

    stage('Prep Mangement VPC') {
        echo "${seperator60}\n${seperator20} Preparing Centrale VPCs \n${seperator60}"
        withCredentials(
            [[
            $class: 'AmazonWebServicesCredentialsBinding',
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
                            terraform plan
                        """
                    } 
            }
        }
    }

    stage("DeployToCentrale") {
        input 'Create Centrale|Management Vpc ?'
    }

    stage('Creating Centrale VPC') {
        echo "${seperator60}\n${seperator20} Building Centrale VPCs \n${seperator60}"
        withCredentials([[$class: 'AmazonWebServicesCredentialsBinding',
            credentialsId: "admin_centrale",
            accessKeyVariable: 'AWS_ACCESS_KEY_ID', 
            secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
        ]]) {
            wrap([$class: 'AnsiColorBuildWrapper', 'colorMapName': 'xterm']){
                    dir("./lesson_13/infra-cicd/aws_centrale/"){
                        sh """
                            terraform apply -auto-approve
                        """
                    } 
            }
        }
    }
    
    stage("PrepSandbox") {
        input 'Prepare Sandbox Vpc ?'
    }

    stage('Prep SandBox VPC') {
        echo "${seperator60}\n${seperator20} Preparing To Create SandBox Vpc \n${seperator60}"
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
                            terraform plan
                        """
                    }                
            }
        }
    }
  
    stage("DeployToSandbox") {
        input 'Create Sandbox Vpc ?'
    }

    stage('Creating SandBox VPC') {
        echo "${seperator60}\n${seperator20} Building SandBox VPC \n${seperator60}"
        withCredentials([[$class: 'AmazonWebServicesCredentialsBinding',
            credentialsId: "admin_sandbox",
            accessKeyVariable: 'AWS_ACCESS_KEY_ID', 
            secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
        ]]) {
            wrap([$class: 'AnsiColorBuildWrapper', 'colorMapName': 'xterm']){
                    dir("./lesson_13/infra-cicd/aws_sandbox/"){
                        sh """
                            terraform apply -auto-approve
                        """
                    }                
            }
        }
    }

    stage("PrepPreprod") {
        input 'Prepare Preprod Vpc ?'
    }

    stage('Prep Preprod VPC') {
        echo "${seperator60}\n${seperator20} Preparing Preprod VPC \n${seperator60}"
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
                            terraform plan
                        """
                    }                
            }
        }
    }

    stage("DeployToPreprod") {
        input 'Creating Preprod Vpc  ?'
    }

    stage('Preprod VPC') {
        echo "${seperator60}\n${seperator20} Building Preprod Vpc \n${seperator60}"
        withCredentials([[$class: 'AmazonWebServicesCredentialsBinding',
            credentialsId: "admin_preprod",
            accessKeyVariable: 'AWS_ACCESS_KEY_ID', 
            secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
        ]]) {
            wrap([$class: 'AnsiColorBuildWrapper', 'colorMapName': 'xterm']){
                    dir("./lesson_13/infra-cicd/aws_preprod/"){
                        sh """
                            terraform apply -auto-approve
                        """
                    }                
            }
        }
    }


    stage("Infra AMIs Build") {
        input 'Start AMI Build For SandBox?'
    }

    stage('SandBox FE & BE AMIs') {
        echo "${seperator60}\n${seperator20} Preprod: Building both frontend and backend amis \n${seperator60}"
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

    stage("Infra AMIs Build") {
        input 'Build AMI for PreProd?'
    }

    stage('Preprod FE & BE AMIs') {
        echo "${seperator60}\n${seperator20} Building both frontend and backend amis \n${seperator60}"
        withCredentials([[$class: 'AmazonWebServicesCredentialsBinding',
            credentialsId: "admin_sandbox",
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