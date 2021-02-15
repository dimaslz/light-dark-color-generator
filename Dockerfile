FROM node:alpine as builder

COPY package.json ./

WORKDIR /app

RUN yarn install

COPY . .

RUN yarn build


FROM nginx:alpine as production

COPY --from=builder /app/dist /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]