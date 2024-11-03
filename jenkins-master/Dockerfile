FROM jenkins/jenkins:lts

# Install necessary plugins (e.g., nodejs, java agents)
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli -f /usr/share/jenkins/ref/plugins.txt

# Expose necessary ports
EXPOSE 8080 50000
