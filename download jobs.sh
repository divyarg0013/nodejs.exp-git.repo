#!/bin/bash

# Replace these variables with your Jenkins server URL and authentication credentials                               
JENKINS_URL=https://jenkins.smartfoodsafe.net/jenkins                                                                   
USERNAME=divya_ravindra
API_TOKEN=115b01c24cc445bdb58e78686041eb8ac0

# Create a directory to store job configurations
mkdir -p job_configs

# List all job names and download configurations
java -jar jenkins-cli.jar -s "$JENKINS_URL" -auth "$USERNAME:$API_TOKEN" list-jobs | while read -r job; do
  echo "Downloading configuration for job: $job"                                                                    
  java -jar jenkins-cli.jar -s "$JENKINS_URL" -auth "$USERNAME:$API_TOKEN" get-job "$job" > "job_configs/$job.xml"  
done


echo "Job configurations downloaded to 'job_configs' directory. 