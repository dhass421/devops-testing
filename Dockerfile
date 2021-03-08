# Multi-stage
# 1) Node image to build static assets
# 2) Nginx image to serve static assets

# Build stage
FROM node:15 AS build

WORKDIR /app

COPY package*.json /app/

RUN npm install

COPY ./ /app/

RUN npm run build

# Nginx 
FROM nginx:1.19.7

WORKDIR /usr/share/nginx/html

# Copy static assets from builder stage
COPY --from=build /app/build/ .

ENTRYPOINT ["nginx", "-g", "daemon off;"]