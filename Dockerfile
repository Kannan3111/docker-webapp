# Build stage
FROM node:18-alpine AS builder
WORKDIR /app
COPY src/package*.json ./
RUN npm install --production
COPY src .

# Runtime stage
FROM node:18-alpine
WORKDIR /app
COPY --from=builder /app .
ENV NODE_ENV=production
EXPOSE 3000
USER node
HEALTHCHECK --interval=30s --timeout=3s \
  CMD wget -qO- http://localhost:3000/health || exit 1
CMD ["node", "server.js"]