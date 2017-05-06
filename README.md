
# SPA+N Starter
##### (Single Page App with Node)

This repo represents all the boilerplate code required for setting up a node app server using express, mongo, redis, along with a single page web app client using vue, all wrapped in docker. This starter is useful for anyone that is trying to just get a quick jumping off point for developing an application, rather than trying to drag all the bits and pieces together. Even if you want just part of the things in this repo, it's really easy to cut out the pieces that you don't need.

### Technologies you'll find here

Operations: Docker, docker-compose, docker hub.
Server: node, express.
Client: vue, vuex, vue-router.

### Basic Principles:

* JavaScript, Node and Web **Best Practices**.
* **Speed of Development**.
* **Elogance**: **Simplicity** while remaining **Complete**.


## Features

#### Server (CoffeeScript):

- File structure that will grow with any size of project. REST focused.
- Node "cluster" support.
- Incorporation of a server.js file for AWS OpsWorks base setup.
- Mongo for general purpose DB.
- Redis for sessions and jobs.
- App level event emitter called 'vent'
- **Passport Account Management**; Local, Google (OAuth), and LinkedIn integrated to start.
- JWT will be the primary authentication mechanism on the server.
- Logger with solid base conventions; Includes log level and datetime.
- Last but not least: A supervisor module that watches the process object for signals and uncaught errors!
- Non-dogmatic use of globals:
  - Many argue that globals are evil, yet ignore that classes and other language constructs are clearly application global. One should use them sparingly, but where it makes sense.
  - Models are all loaded in to the global namespace based on filename.
  - Common libraries are loaded globally, since they are often used in many places: _, app, logger, vent, events, and constants. 

#### Client (ES6):

- Browserify for asset pipeline.
- Vue, vuex, vue-router.
- LESS for modern, functional CSS.
- Pug for clean HTML Temlates in .vue files.
- Bootstrap for level setting in CSS, brought in via LESS.
- Hot reloading.
- Google Analytics by default for pages and ng-ui-routes.
- Basic pages for login, registration, forgotten password, password reset, and account edit.

Minimum Browsers Requirements based on libraries: IE11+, all evergreen browsers.


## What You Need

* Docker (17.03.1) and docker compose. All other requirements are managed by docker.
* A strong knowledge of docker, node, and SPAs.<br/>
  It bears mentioning that this is not meant to be a gentle introduction to web dev. You're going to be very confused if you don't strongly understand development using es6, node, modern web browsers, docker, and modern architectural styles.


## Credits

* This starter is three major rewrites removed from Sahat Yalkabov's amazing and fantastic [Hackathon Starter 2.0](https://github.com/sahat/hackathon-starter). The changes are so fundamental from that starter at this point that it's not even useful to mention all of them here. Some big ticket items include using appropriate compilers for coffee and es6, ripping out all the extra pieces for test API calls to several services, removing most all of the OAuth agents, and many other things.

## Useful Docker Commands

Clean up commands for untagged and stopped images:
```
docker ps -aqf status=exited | xargs docker rm
docker images -qf dangling=true | xargs docker rmi
```

## Useful Resources

- [CoffeeScript](http://coffeescript.org/) - Main coffeescript site.
- [Jade Syntax Documentation by Example](http://naltatis.github.io/jade-syntax-docs/#attributes) - Even better than official Jade docs.
- [JS to CoffeeScript converter](http://js2coffee.org/) - When moving over to CoffeeScript, this can be very useful.
- [HTML to Jade converter](http://html2jade.org/) - When sniping html snippets, this can be a time saver.
- [JavascriptOO](http://www.javascriptoo.com/) - A directory of JavaScript libraries with examples, CDN links, statistics, and videos.
- [JS Recipes](http://jsrecipes.org) - JavaScript tutorials for backend and frontend development.

## Recommended Design Resources

- [Bootsnipp](http://bootsnipp.com/) - Code snippets for Bootstrap.
- [UIBox](http://www.uibox.in) - Curated HTML, CSS, JS, UI components.
- [Bootstrap Zero](http://bootstrapzero.com/) - Free Bootstrap templates themes.
- [Colors](http://clrs.cc) - A nicer color palette for the web.
- [Creative Button Styles](http://tympanus.net/Development/CreativeButtons/) - awesome button styles.
- [Creative Link Effects](http://tympanus.net/Development/CreativeLinkEffects/) - Beautiful link effects in CSS.
- [Medium Scroll Effect](http://codepen.io/andreasstorm/pen/pyjEh) - Fade in/out header background image as you scroll.


# License

The MIT License (MIT)

Copyright (c) 2014 Christopher WJ Rueber

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
