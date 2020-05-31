FROM node:alpine as builder
WORKDIR /app
COPY . ./
RUN npm install
RUN npm run-script build

FROM nginx:stable-alpine
COPY nginx/nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]