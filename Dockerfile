FROM node:6.10

RUN npm cache clean
RUN npm i -g node-gyp

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY package.json bower.json .bowerrc /usr/src/app/
RUN npm install

COPY . /usr/src/app

ENV PORT 1337
EXPOSE 1337
CMD [ "npm", "start" ]
