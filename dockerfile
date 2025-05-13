# Stage 1: Build stage
FROM node:18 AS build

# Set working directory for the build stage
WORKDIR /app

# Copy package.json and package-lock.json to install dependencies
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy all the application code (excluding files in .dockerignore)
COPY . .

# Stage 2: Production stage
FROM node:alpine AS production
# Set working directory for the production stage
WORKDIR /app

# Copy only the necessary files from the build stage (dependencies and built files)
COPY --from=build /app /app

# Expose the necessary ports
EXPOSE 8000
EXPOSE 8001

# Start the server
CMD ["npm", "run", "dev"]

