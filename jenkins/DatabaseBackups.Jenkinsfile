pipeline {
    agent any
    stages {
        stage('Database Backups') {
            parallel {
                stage('Links') {
                    steps {
                        sh '/var/build/scripts/backup-database.sh links'
                    }
                }
                stage('Memories Ninja') {
                    steps {
                        sh '/var/build/scripts/backup-database.sh photos'
                    }
                }
                stage('Whats On') {
                    steps {
                        sh '/var/build/scripts/backup-database.sh whatson'
                    }
                }
            }
        }
    }
}
