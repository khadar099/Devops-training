 What This Pipeline Does:
Detects the branch: develop, SIT, UAT, or master

Maps the branch to the correct environment

Loads .env file for environment-specific settings

Pulls secrets from Vault (Docker credentials)

Runs SonarQube analysis

Runs Qualys scan

Builds and pushes Docker image to JFrog

Deploys to EKS using Helm


pipeline {
  agent any

  environment {
    BRANCH = "${env.BRANCH_NAME}"
  }

  stages {

    stage('Determine Environment') {
      steps {
        script {
          switch (BRANCH) {
            case 'develop':
              env.ENV_NAME = 'dev'
              break
            case 'SIT':
              env.ENV_NAME = 'sit'
              break
            case 'UAT':
              env.ENV_NAME = 'uat'
              break
            case 'master':
              env.ENV_NAME = 'prod'
              break
            default:
              error("Unsupported branch: ${BRANCH}")
          }
          env.ENV_FILE = ".env.${ENV_NAME}"
          env.VAULT_PATH = "secret/${ENV_NAME}/docker"
        }
      }
    }

    stage('Load .env File') {
      steps {
        script {
          def envVars = readFile(env.ENV_FILE).split("\n")
          envVars.each { line ->
            if (line && !line.startsWith("#")) {
              def (key, value) = line.tokenize("=")
              env[key.trim()] = value.trim()
            }
          }
        }
      }
    }

    stage('Fetch Secrets from Vault') {
      steps {
        script {
          env.DOCKER_USERNAME = sh(returnStdout: true, script: "vault kv get -field=username ${VAULT_PATH}").trim()
          env.DOCKER_PASSWORD = sh(returnStdout: true, script: "vault kv get -field=password ${VAULT_PATH}").trim()
        }
      }
    }

    stage('SonarQube Scan') {
      steps {
        withSonarQubeEnv('SonarQubeServer') {
          sh 'mvn clean verify sonar:sonar'
        }
      }
    }

    stage('Build Docker Image') {
      steps {
        sh "docker build -t ${DOCKER_REPO}/${DOCKER_IMAGE_NAME}:${BRANCH} ."
      }
    }

    stage('Qualys Security Scan') {
      steps {
        sh "qualys-scan.sh ${DOCKER_REPO}/${DOCKER_IMAGE_NAME}:${BRANCH}" // Adjust with your Qualys script
      }
    }

    stage('Push to JFrog Artifactory') {
      steps {
        sh "docker login -u ${DOCKER_USERNAME} -p ${DOCKER_PASSWORD} ${DOCKER_REPO}"
        sh "docker push ${DOCKER_REPO}/${DOCKER_IMAGE_NAME}:${BRANCH}"
      }
    }

    stage('Deploy to EKS with Helm') {
      steps {
        sh """
        helm upgrade --install ${HELM_RELEASE_NAME}-${ENV_NAME} ./helm/backend \
          --namespace=${NAMESPACE} \
          --set image.repository=${DOCKER_REPO}/${DOCKER_IMAGE_NAME} \
          --set image.tag=${BRANCH} \
          --values helm/values/${ENV_NAME}.yaml
        """
      }
    }
  }

  post {
    always {
      echo "Pipeline for branch: ${BRANCH} deployed to environment: ${ENV_NAME}"
    }
  }
}
