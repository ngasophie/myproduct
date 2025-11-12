# Build stage
FROM node:20-alpine AS builder
WORKDIR /app

# Copy package.json và cài dependencies
COPY package*.json ./
RUN npm install

# Copy toàn bộ source code
COPY . .

# Build NestJS
RUN npm run build

# Production stage
FROM node:20-alpine
WORKDIR /app

# Copy node_modules từ builder
COPY --from=builder /app/node_modules ./node_modules
# Copy dist từ builder
COPY --from=builder /app/dist ./dist

# Expose port NestJS
EXPOSE 3000

# Chạy NestJS
CMD ["node", "dist/main.js"]
