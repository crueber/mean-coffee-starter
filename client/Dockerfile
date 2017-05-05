FROM node:6.10

RUN npm cache clean
RUN npm i -g node-gyp

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY . /usr/src/app

ENV PORT 1338
EXPOSE 1338
CMD [ "yarn", "run", "build" ]
