FROM node:alpine as builder

ENV PROJECTDIR /app
ENV NODE_ENV production

COPY package.json ./
COPY yarn.lock ./

WORKDIR $PROJECTDIR

RUN yarn install

COPY . .

RUN yarn build


FROM nginx:alpine

WORKDIR /usr/share/nginx/html
COPY --from=builder /app/dist /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]