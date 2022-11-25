FROM node:16.16.0-alpine as build
# Installing libvips-dev for sharp Compatibility
RUN apk update && apk add build-base gcc autoconf automake zlib-dev libpng-dev vips-dev && rm -rf /var/cache/apk/* > /dev/null 2>&1
ARG NODE_ENV=production
ENV NODE_ENV=${NODE_ENV}
WORKDIR /opt/
COPY package.json ./package.json
COPY yarn.lock ./yarn.lock
COPY .yarn ./.yarn
COPY .yarnrc.yml ./.yarnrc.yml

ENV PATH /opt/node_modules/.bin:$PATH
RUN yarn install --network-timeout 600000
COPY ./ .
RUN yarn build


FROM node:16.16.0-alpine
RUN apk add vips-dev
RUN rm -rf /var/cache/apk/*
ARG NODE_ENV=production
ENV NODE_ENV=${NODE_ENV}
WORKDIR /opt
COPY --from=build /opt ./
ENV PATH /opt/node_modules/.bin:$PATH
EXPOSE 1337
CMD ["yarn", "start"]
