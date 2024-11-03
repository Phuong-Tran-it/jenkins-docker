FROM jenkins/inbound-agent:latest

USER root

COPY start.sh /usr/local/bin/start.sh

RUN chmod +x /usr/local/bin/start.sh

RUN apt-get update && \
    apt-get install -y openjdk-17-jdk wget && \
    rm -rf /var/lib/apt/lists/*

# Set JAVA_HOME environment variable
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
ENV PATH=$JAVA_HOME/bin:$PATH

# Install Node.js
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get update \
    && apt-get install -y nodejs\
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# RUN usermod -aG docker jenkins

# Expose working directory
WORKDIR /home/jenkins

EXPOSE 3000
ENTRYPOINT ["/usr/local/bin/start.sh"]
