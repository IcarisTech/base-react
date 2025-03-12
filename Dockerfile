
FROM node:16-alpine AS build
WORKDIR /app

# Instala dependencias y construye la aplicación
COPY package.json package-lock.json ./
RUN npm install
COPY . .
RUN npm run build

# Crea la imagen final con Nginx
FROM nginx:alpine
COPY --from=build /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
