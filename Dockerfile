# Sử dụng image Node để build
FROM node:18 AS build-stage
WORKDIR /app
COPY package.json ./
RUN npm install
COPY . .
RUN npm run build

# Sử dụng Nginx để chạy Vue
FROM nginx:stable-alpine
COPY --from=build-stage /app/dist /usr/share/nginx/html
CMD ["nginx", "-g", "daemon off;"]