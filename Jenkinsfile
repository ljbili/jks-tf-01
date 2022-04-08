pipeline{
    agent any 
    tools {
        "org.jenkinsci.plugins.terraform.TerraformInstallation" "terraform"
    }
    stages {

        stage ("terraform init") {
            steps {
                credentialsId: 'Azure',
                subscriptionIdVariable: 'edfaf05d-e154-4419-8020-f5e20f278d63',
                clientIdVariable: 'id-terraformtest',
                clientSecretVariable: 'eW9yDKZL~_rERWVdqB7p1Q1~hB8oLi02aj',
                tenantIdVariable: '58357bf7-2207-40ed-ab8d-f21fcf2a1035'                
                sh 'terraform init'
            }
        }
        stage ("terraform validate") {
            steps {
                sh 'terraform validate'
            }
        }
        stage ("terrafrom plan") {
            steps {
                sh 'terraform plan '
            }
        }
        stage ("terraform apply") {
            steps {
                sh 'terraform apply --auto-approve'
            }
        }
    }
  
}
