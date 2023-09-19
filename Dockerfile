#Use the official Jenkins LTS base image
FROM jenkins/jenkins:lts
# Install Docker (if not already installed)
USER root
RUN apt-get update && apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
RUN apt-get update && apt-get install -y docker-ce docker-ce-cli containerd.io
USER jenkins
# Install Node.js and npm (if not already installed)
USER root
RUN curl -fsSL https://deb.nodesource.com/setup_14.x | bash -
RUN apt-get install -y nodejs
USER jenkins
# Install AWS CLI (if not already installed)
USER root
RUN apt-get install -y awscli git 
USER jenkins
# Install necessary Jenkins plugins (you can customize this list)
#RUN /usr/local/bin/install-plugins.sh \
    
  #  pipeline-utility-steps
# Set up Jenkins environment variables (customize as needed)
# ENV AWS_ACCESS_KEY_ID=your_access_key_id
# ENV AWS_SECRET_ACCESS_KEY=your_secret_access_key
# Expose the Jenkins port
EXPOSE 8080