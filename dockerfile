FROM node:alpine as builder

WORKDIR '/opt/app'

ENV http_proxy http://squid-test.lb.ge:8080
ENV https_proxy http://squid-test.lb.ge:8080

COPY package.json .

RUN npm install

COPY . .

RUN npm run build

FROM nginx

COPY --from=builder /opt/app/build /usr/share/nginx/html 
