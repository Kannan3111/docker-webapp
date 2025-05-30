# Stage 1: Build
FROM node:18-alpine as builder
WORKDIR /app

# Copy package files first for better caching
COPY package*.json ./

# Install dependencies (including devDependencies)
RUN npm install

# Copy all files
COPY . .

# Stage 2: Runtime
FROM node:18-alpine
WORKDIR /app

# Copy only necessary files from builder
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/src ./src

# Environment variables
ENV NODE_ENV=production
ENV PORT=3000

# Expose port and run
EXPOSE 3000
USER node
CMD ["npm", "start"]