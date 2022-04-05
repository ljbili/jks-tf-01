pipeline{
    agent any 
    tools {
        "org.jenkinsci.plugins.terraform.TerraformInstallation" "terraform"
    }
    environment {
        TF_HOME = tool('terraform')
        TF_IN_AUTOMATION = "true"
        PATH = "$TF_HOME:$PATH"
    }
    stages {
    
        stage('Terraform Init'){
            
            steps {
                    ansiColor('xterm') {
                    withCredentials([azureServicePrincipal(
                    credentialsId: 'Azure',
                    subscriptionIdVariable: 'edfaf05d-e154-4419-8020-f5e20f278d63',
                    clientIdVariable: 'id-terraformtest',
                    clientSecretVariable: 'eW9yDKZL~_rERWVdqB7p1Q1~hB8oLi02aj',
                    tenantIdVariable: '58357bf7-2207-40ed-ab8d-f21fcf2a1035'
                ), string(credentialsId: 'access_key', variable: 'ARM_ACCESS_KEY')]) {
                        
                        sh """
                                
                        echo "Initialising Terraform"
                        terraform init -backend-config="access_key=$ARM_ACCESS_KEY"
                        """
                           }
                    }
             }
        }

        stage('Terraform Validate'){
            
            steps {
                    ansiColor('xterm') {
                    withCredentials([azureServicePrincipal(
                    credentialsId: 'Jenkins',
                    subscriptionIdVariable: 'edfaf05d-e154-4419-8020-f5e20f278d63',
                    clientIdVariable: 'id-terraformtest',
                    clientSecretVariable: 'eW9yDKZL~_rERWVdqB7p1Q1~hB8oLi02aj',
                    tenantIdVariable: '58357bf7-2207-40ed-ab8d-f21fcf2a1035'
                ), string(credentialsId: 'access_key', variable: 'ARM_ACCESS_KEY')]) {
                        
                        sh """
                                
                        terraform validate
                        """
                           }
                    }
             }
        }

        stage('Terraform Plan'){
            steps {

                    ansiColor('xterm') {
                    withCredentials([azureServicePrincipal(
                    credentialsId: 'Jenkins',
                    subscriptionIdVariable: 'edfaf05d-e154-4419-8020-f5e20f278d63',
                    clientIdVariable: 'id-terraformtest',
                    clientSecretVariable: 'eW9yDKZL~_rERWVdqB7p1Q1~hB8oLi02aj',
                    tenantIdVariable: '58357bf7-2207-40ed-ab8d-f21fcf2a1035'
                ), string(credentialsId: 'access_key', variable: 'ARM_ACCESS_KEY')]) {
                        
                        sh """
                        
                        echo "Creating Terraform Plan"
                        terraform plan -var "client_id=id-terraformtest" -var "client_secret=eW9yDKZL~_rERWVdqB7p1Q1~hB8oLi02aj" -var "subscription_id=edfaf05d-e154-4419-8020-f5e20f278d63" -var "tenant_id=58357bf7-2207-40ed-ab8d-f21fcf2a1035"
                        """
                        }
                }
            }
        }

        stage('Waiting for Approval'){
            steps {
                timeout(time: 10, unit: 'MINUTES') {
                    input (message: "Deploy the infrastructure?")
                }
            }
        
        }
    

        stage('Terraform Apply'){
            steps {
                    ansiColor('xterm') {
                    withCredentials([azureServicePrincipal(
                    credentialsId: 'Jenkins',
                    subscriptionIdVariable: 'edfaf05d-e154-4419-8020-f5e20f278d63',
                    clientIdVariable: 'id-terraformtest',
                    clientSecretVariable: 'eW9yDKZL~_rERWVdqB7p1Q1~hB8oLi02aj',
                    tenantIdVariable: '58357bf7-2207-40ed-ab8d-f21fcf2a1035'
                ), string(credentialsId: 'access_key', variable: 'ARM_ACCESS_KEY')]) {

                        sh """
                        echo "Applying the plan"
                        terraform apply -auto-approve -var "client_id=$id-terraformtest" -var "client_secret=$eW9yDKZL~_rERWVdqB7p1Q1~hB8oLi02aj" -var "subscription_id=$edfaf05d-e154-4419-8020-f5e20f278d63" -var "tenant_id=$58357bf7-2207-40ed-ab8d-f21fcf2a1035"
                        """
                                }
                }
            }
        }

    }
}