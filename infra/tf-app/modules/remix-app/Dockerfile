# Stage 1: Build the Remix app
FROM node:18 AS builder

# Set working directory
WORKDIR /app

# Copy app files
COPY . .

# Install dependencies and build the app
RUN npm install
RUN npm run build

# Stage 2: Run the app in production
FROM node:18-slim

WORKDIR /app

# Copy only the build output and node_modules from the builder
COPY --from=builder /app .

# Expose the app port (Remix defaults to 3000)
EXPOSE 3000

# Start the Remix app
CMD ["npm", "run", "start"]
