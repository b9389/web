pipeline {
    agent {
        dockerfile true
    }
    stages {
        stage('Build') {
            steps {
                sh 'pnpm install'
                sh 'pnpm build'
            }
        }
        stage('Test') {
            steps {
                sh 'pnpm test'
            }
        }
        stage('Run') {
            steps {
                sh 'pnpm start'
            }
        }
    }
}
