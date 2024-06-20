# Base image
FROM jenkins/inbound-agent:latest-jdk11

# Install node, npm, pnpm, and other dependencies
USER root
RUN apt-get update && apt-get install -y curl gnupg2

# Install Node.js 18 (current LTS version)
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
RUN apt-get install -y nodejs

# Install pnpm and TypeScript globally
RUN npm install -g pnpm typescript

# Switch back to the Jenkins user
USER jenkins

# Set up the working directory
WORKDIR /home/jenkins/agent

# Copy the Meshtastic web application code
COPY . .

# Install dependencies
RUN pnpm install

# Install missing type definitions
RUN pnpm add @types/node @types/w3c-web-serial @types/web-bluetooth @types/vite/client --save-dev

# Build the application
RUN pnpm build

# Expose the application port
EXPOSE 3000

# Start the application
CMD ["pnpm", "start"]
