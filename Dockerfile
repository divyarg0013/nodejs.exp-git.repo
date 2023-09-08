ROM jenkins/jenkins:lts

USER root

# Install Git, Node.js/npm, and AWS CLI
RUN apt-get update && apt-get install -y \
    git \
    nodejs \
    npm \
    Dockerfile \
    awscli
 
USER jenkins
