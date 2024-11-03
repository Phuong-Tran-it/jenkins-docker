# Explicitly specify platform for M1 compatibility
FROM --platform=linux/arm64 jenkins/inbound-agent:latest

USER root

COPY start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh

# Install essential tools and OpenJDK 17
RUN apt-get update && \
    apt-get install -y \
    wget \
    curl \
    git \
    openjdk-17-jdk \
    lsof \
    && rm -rf /var/lib/apt/lists/*

# Set Java environment variables
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-arm64
ENV PATH="${JAVA_HOME}/bin:${PATH}"

# Set up Maven environment variables
ENV MAVEN_VERSION=3.9.6
ENV MAVEN_HOME=/usr/share/maven
ENV M2_HOME=/usr/share/maven
ENV PATH="${MAVEN_HOME}/bin:${PATH}"

# Install Maven - using a more reliable mirror
RUN wget https://archive.apache.org/dist/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz -P /tmp && \
    tar xf /tmp/apache-maven-${MAVEN_VERSION}-bin.tar.gz -C /usr/share && \
    ln -s /usr/share/apache-maven-${MAVEN_VERSION} /usr/share/maven && \
    rm -f /tmp/apache-maven-${MAVEN_VERSION}-bin.tar.gz

# Verify installations and print architecture information
RUN arch && \
    uname -m && \
    which java && \
    java -version && \
    echo "JAVA_HOME=${JAVA_HOME}" && \
    which mvn && \
    mvn -version

# Expose working directory
WORKDIR /home/jenkins
EXPOSE 3001
ENTRYPOINT ["/usr/local/bin/start.sh"]