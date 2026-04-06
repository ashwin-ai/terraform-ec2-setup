pipeline {
    agent any

    environment {
        AWS_DEFAULT_REGION = 'ap-south-1'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/ashwin-ai/terraform-ec2-setup.git'
            }
        }

        stage('Terraform with Vault Secrets') {
            steps {
                withVault([
                    vaultSecrets: [[
                        path: 'secret/aws',
                        secretValues: [
                            [envVar: 'AWS_ACCESS_KEY_ID', vaultKey: 'AWS_ACCESS_KEY_ID'],
                            [envVar: 'AWS_SECRET_ACCESS_KEY', vaultKey: 'AWS_SECRET_ACCESS_KEY']
                        ]
                    ]]
                ]) {
                    sh 'terraform init'
                    sh 'terraform validate'
                    sh 'terraform plan'
                }
            }
        }
    }

    post {
        success {
            echo 'Terraform pipeline completed successfully!'
        }
        failure {
            echo 'Terraform pipeline failed!'
        }
    }
}
