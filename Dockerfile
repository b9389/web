# Base image
FROM jenkins/inbound-agent:latest-jdk11

# Install node, npm, pnpm, and other dependencies
USER root
RUN apt-get update && apt-get install -y curl gnupg2

# Install Node.js 18 (current LTS version)
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
RUN apt-get install -y nodejs

# Install pnpm
RUN npm install -g pnpm

# Switch back to the Jenkins user
USER jenkins

# Set up the working directory
WORKDIR /home/jenkins/agent

# Copy the Meshtastic web application code
COPY . .

# Install dependencies and build the application
RUN pnpm install
RUN pnpm build

# Expose the application port
EXPOSE 3000

# Start the application
CMD ["pnpm", "start"]
