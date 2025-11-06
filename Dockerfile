# Use a stable Node LTS
FROM node:18-bullseye

# Set working dir
WORKDIR /app

# Copy package manifests first (cache npm install)
COPY package*.json ./

# Install root-level dependencies (concurrently etc.)
RUN npm install --production=false

# Copy the rest of the project
COPY . .

# Install client dependencies (client folder)
WORKDIR /app/client
RUN npm install --production=false

# Back to root
WORKDIR /app

# Expose ports used by your app
EXPOSE 3000 6060

# Default command: run your existing dev script which uses concurrently
# Keep it as an array form to avoid shell wrapping issues
CMD ["npm", "run", "dev"]
