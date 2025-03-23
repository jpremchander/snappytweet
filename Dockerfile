# ------------ Backend Build Stage ------------
FROM node:18 AS backend

# Set working directory
WORKDIR /app/backend

# Copy backend dependencies and install
COPY backend/package*.json ./
RUN npm install

# Copy backend code
COPY backend/ .

# Expose backend port
EXPOSE 5000

# Install nodemon globally for hot reload
RUN npm install -g nodemon

# ------------ Frontend Build Stage ------------
FROM node:18 AS frontend

# Set working directory
WORKDIR /app/frontend

# Copy frontend dependencies and install
COPY frontend/package*.json ./
RUN npm install --force

# Copy frontend code
COPY frontend/ .

# Build the frontend app
RUN npm run build

# Expose frontend port
EXPOSE 3000

# ------------ Final Stage (Combined Container) ------------
FROM node:18 AS final

# Set working directory
WORKDIR /app

# Copy backend and frontend build artifacts
COPY --from=backend /app/backend /app/backend
COPY --from=frontend /app/frontend /app/frontend

# Install Docker Compose to run both services
RUN npm install -g docker-compose

# Expose backend and frontend ports
EXPOSE 3000 5000

# Command to start both services with Docker Compose
CMD ["docker-compose", "up"]
