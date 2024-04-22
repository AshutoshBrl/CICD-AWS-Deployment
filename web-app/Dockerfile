FROM nginx:1.25.5-alpine-slim
WORKDIR /app
COPY ./web-app/ /usr/share/nginx/html
expose 80
CMD ["nginx", "-g", "daemon off;"]
