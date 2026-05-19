FROM jenkins/jenkins:lts

USER root

# Install system packages
RUN apt-get update && apt-get install -y libatomic1 unzip curl git

# Copy Docker CLI
COPY --from=docker:latest /usr/local/bin/docker /usr/local/bin/

# Install AWS CLI v2
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip -q awscliv2.zip && \
    ./aws/install && \
    rm -rf awscliv2.zip aws/

# Install kubectl
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
    chmod +x kubectl && \
    mv kubectl /usr/local/bin/

# Install Helm CLI
RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 && \
    chmod 700 get_helm.sh && \
    ./get_helm.sh

RUN apt-get update && \
    apt-get install -y postgresql-client && \
    rm -rf /var/lib/apt/lists/*
# Drop back to the jenkins user to install the Helm plugin locally
USER jenkins

# Install the helm-git plugin
RUN helm plugin install https://github.com/aslafy-z/helm-git
