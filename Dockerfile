# Stage 1: Build
FROM node:18-alpine as builder
WORKDIR /app

# Copy package files first for better caching
COPY src/package*.json ./

# Install dependencies
RUN npm install

# Copy all source files
COPY src .

# Stage 2: Runtime
FROM node:18-alpine
WORKDIR /app

# Copy only necessary files from builder
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/public ./public
COPY --from=builder /app/server.js ./

# Environment variables
ENV NODE_ENV=production
ENV PORT=3000

# Expose port and run
EXPOSE 3000
USER node
CMD ["node", "server.js"]