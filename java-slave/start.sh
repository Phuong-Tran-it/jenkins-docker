#!/bin/sh
apt-get update && apt-get install -y \
    git \
    curl \
    wget \
    zip \
    unzip \
    build-essential \
    apt-transport-https \
    ca-certificates \
    gnupg \
    lsb-release \
    software-properties-common \
    && rm -rf /var/lib/apt/lists/*

mkdir -p /etc/apt/keyrings \
    && curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg \
    && echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
    $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null \
    && apt-get update \
    && apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin \
    && rm -rf /var/lib/apt/lists/*

service docker start

echo "-jar /usr/share/jenkins/agent.jar -url $JENKINS_URL -secret $SECRET -name $SLAVE_NAME -webSocket"
java -jar /usr/share/jenkins/agent.jar -url "$JENKINS_URL" -secret "$SECRET" -name "$SLAVE_NAME" -webSocket