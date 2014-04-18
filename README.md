MEAN Coffee Starter
===================

#### Inspired by Hackathon Starter 2.0

A boilerplate for Mongo, ExpressJS, Angular, and NodeJS using CoffeeScript. This boilerplate was forked and completely rewritten from Sahat Yalkabov's amazing and fantastic [Hackathon Starter 2.0](https://github.com/sahat/hackathon-starter)! 

I'm going to spare you all the reasons why this was built, because you should go check out Sahat's intro if you're really interested in that; It is an extremely thorough introduction. Suffice it to say, this rewrite focuses on a different avenue: Single Page Applications written with Angular. It wouldn't be very hard to convert it over to Ember or Backbone or whatever you prefer, should you want to go a different route than Angular.

Guiding Principles:

* Speed of Development
* Node Best Practices
* Simplicity
* Generic
* Reusable

If you're curious about what's different from Sahat's starter kit and this one, here are the primary bits:

* CoffeeScript everywhere. Much cleaner syntax.
* Major structural changes that incorporate best practices for large/complex ExpressJS applications.
* Only two OAuth agents are available: LinkedIn and Google. Local is available.
* No third party services: Facebook, Github, Twitter, Venmo, Stripe, FourSquare, Tumblr, Steam.
* Extra modules: CoffeeScript, Nodemon, Bower. Soon to be Grunt.
* No generator to change OAuth- No reason to second guess the intentions of the developer.
* CSRF removed. Unnecessary when dealing with SPA applications.

What You Need
-------------

* NodeJS >0.10.x installed. I recommend a node version system such as NVM.
* Bower and Grunt packages installed globally via NPM, and accessible via command line.
* MongoDB >2.2 installed.
* A strong knowledge of how to code in both the web browser and server spaces.

Features
--------

- **Local Authentication** using Email and Password
- **OAuth 2.0 Authentication** via Google, LinkedIn
- Flash notifications with animations by [animate.css](http://daneden.github.io/animate.css/)
- Improved MVC Project Infrastructure
- Node.js clusters support (PM2 Recommended instead, though)
- Rails 3.1-style asset pipeline by connect-assets (See FAQ)
- LESS stylesheets (auto-compiled without any Gulp/Grunt hassle)
- Bootstrap 3 + Flat UI + iOS7
- **Account Management**
 - Gravatar
 - Profile Details
 - Change Password
 - Forgot Password
 - Reset Password
 - Link multiple OAuth strategies to one account
 - Delete Account

Obtaining API Keys
------------------

<img src="http://images.google.com/intl/en_ALL/images/srpr/logo6w.png" width="200">
- Visit [Google Cloud Console](https://cloud.google.com/console/project)
- Click **CREATE PROJECT** button
- Enter *Project Name*, then click **CREATE**
- Then select *APIs & auth* from the sidebar and click on *Credentials* tab
- Click **CREATE NEW CLIENT ID** button
 - **Application Type**: Web Application
 - **Authorized Javascript origins**: http://localhost:3000
 - **Authorized redirect URI**: http://localhost:3000/auth/google/callback
- Copy and paste *Client ID* and *Client secret* keys into `config/secrets.js`

:exclamation: **Note:** When you ready to deploy to production don't forget to
add your new url to *Authorized Javascript origins* and *Authorized redirect URI*,
e.g. `http://my-awesome-app.herokuapp.com` and
`http://my-awesome-app.herokuapp.com/auth/google/callback` respectively.
The same goes for other providers.

<hr>

<img src="http://www.danpontefract.com/wp-content/uploads/2014/02/logo-linkedin.png" width="200">
- Sign in at [LinkedIn Developer Network](http://developer.linkedin.com/)
- From the account name dropdown menu select **API Keys**
 - *It may ask you to sign in once again*
- Click **+ Add New Application** button
- Fill out all *required* fields
- For **Default Scope** make sure *at least* the following is checked:
 - `r_fullprofile`
 - `r_emailaddress`
 - `r_network`
- Finish by clicking **Add Application** button
- Copy and paste *API Key* and *Secret Key* keys into `config/secrets.js`
 - *API Key* is your **clientID**
 - *Secret Key* is your **clientSecret**

<hr>


List of Packages
----------------

| Package                         | Description   |
| ------------------------------- |:-------------:|
| async                           | Utility library that provides asynchronous control flow. |
| bcrypt-nodejs                   | Library for hashing and salting user passwords. |
| cheerio                         | Scrape web pages using jQuery-style syntax.  |
| connect-assets                  | Compiles LESS stylesheets, concatenates & minifies JavaScript. |
| connect-mongo                   | MongoDB session store for Express. |
| csso                            | Dependency for connect-assets library to minify CSS. |
| express                         | Node.js web framework. |
| body-parser                     | Express 4.0 middleware. |
| cookie-parser                   | Express 4.0 middleware. |
| static-favicon                  | Express 4.0 middleware. |
| express-session                 | Express 4.0 middleware. |
| compression                     | Express 4.0 middleware. |
| errorhandler                    | Express 4.0 middleware. |
| method-override                 | Express 4.0 middleware. |
| express-flash                   | Provides flash messages for Express. |
| express-validator               | Easy form validation for Express. |
| jade                            | Template engine for Express. |
| less                            | LESS compiler. Used implicitly by connect-assets. |
| mongoose                        | MongoDB ODM. |
| node-linkedin                   | LinkedIn API library. |
| nodemailer                      | Node.js library for sending emails. |
| passport                        | Simple and elegant authentication library for node.js |
| passport-google-oauth           | Sign-in with Google plugin. |
| passport-local                  | Sign-in with Username and Password plugin. |
| passport-linkedin-oauth2        | Sign-in with LinkedIn plugin. |
| passport-oauth                  | Allows you to set up your own OAuth 1.0a and OAuth 2.0 strategies. |
| request                         | Simplified HTTP request library. |
| underscore                      | Handy JavaScript utlities library. |
| uglify-js                       | Dependency for connect-assets library to minify JS. |
| validator                       | Used in conjunction with express-validator in **controllers/api.js**. |
| mocha                           | Test framework. |
| chai                            | BDD/TDD assetion library. |
| supertest                       | HTTP assertions library. |
| mstring                         | Multi-line strings for generator. |
| inquirer                        | Interactive command line interface for generator. |
| colors                          | Pretty output colors for generator. |
| [Nodemon](https://github.com/remy/nodemon) | Run node while watching for changes. |

Useful Tools and Resources
--------------------------

- [JS Recipes](http://jsrecipes.org) - JavaScript tutorials for backend and frontend development.
- [Jade Syntax Documentation by Example](http://naltatis.github.io/jade-syntax-docs/#attributes) - Even better than official Jade docs.
- [HTML to Jade converter](http://html2jade.aaron-powell.com) - Extremely valuable when you need to quickly copy and paste HTML snippets from the web.
- [JavascriptOO](http://www.javascriptoo.com/) - A directory of JavaScript libraries with examples, CDN links, statistics, and videos.
- [JS to CoffeeScript converter](http://js2coffee.org/) - When moving over to CoffeeScript, this can be very useful.
- [Node Inspector](https://github.com/node-inspector/node-inspector) - Node.js debugger based on Chrome Developer Tools.

Recommended Design Resources
----------------------------

- [Bootsnipp](http://bootsnipp.com/) - Code snippets for Bootstrap.
- [UIBox](http://www.uibox.in) - Curated HTML, CSS, JS, UI components.
- [Bootstrap Zero](http://bootstrapzero.com/) - Free Bootstrap templates themes.
- [Google Bootstrap](http://todc.github.io/todc-bootstrap/) - Google-styled theme for Bootstrap.
- [Font Awesome Icons](http://fortawesome.github.io/Font-Awesome/icons/) - It's already part of the Hackathon Starter, so use this page as a reference.
- [Colors](http://clrs.cc) - A nicer color palette for the web.
- [Creative Button Styles](http://tympanus.net/Development/CreativeButtons/) - awesome button styles.
- [Creative Link Effects](http://tympanus.net/Development/CreativeLinkEffects/) - Beautiful link effects in CSS.
- [Medium Scroll Effect](http://codepen.io/andreasstorm/pen/pyjEh) - Fade in/out header background image as you scroll.

Recommended Node.js Libraries
-----------------------------

- [geoip-lite](https://github.com/bluesmoon/node-geoip) - Geolocation coordinates from IP address.
- [Filesize.js](http://filesizejs.com/) - Pretty file sizes, e.g. `filesize(265318); // "265.32 kB"`.
- [Numeral.js](http://numeraljs.com) - Library for formatting and manipulating numbers.
- [node-taglib](https://github.com/nikhilm/node-taglib) - Library for reading the meta-data of several popular audio formats.

Recommended Client-side Libraries
---------------------------------

- [selectize.js](http://brianreavis.github.io/selectize.js/) - Similar to Chosen, Select 2, et al. Textbox/Select hybrid.


NodeJS Pro Tips
--------

- When installing an NPM package, add a *--save* flag, and it will be automatially added to `package.json` as well. For example, `npm install --save moment`.
- Use [async.parallel()](https://github.com/caolan/async#parallel) when you need to run multiple asynchronous tasks, and then render a page, but only when all tasks are completed. For example, you might want to scrape 3 different websites for some data and render the results in a template after all 3 websites have been scraped.
- Need to find a specific object inside an Array? Use [_.findWhere](http://underscorejs.org/#findWhere) function from Underscore.js. For example, this is how you would retrieve a Twitter token from database: `var token = _.findWhere(req.user.tokens, { kind: 'twitter' });`, where 1st parameter is an array, and a 2nd parameter is an object to search for.


Mongoose Cheatsheet
-------------------

#### Find all users:
```js
User.find(function(err, users) {
  console.log(users);
});
```

#### Find a user by email:
```js
var userEmail = 'example@gmail.com';
User.findOne({ email: userEmail }, function(err, user) {
  console.log(user);
});
```

#### Find 5 most recent user accounts:
```js
User
  .find()
  .sort({ _id: -1 })
  .limit(5)
  .slaveOk()
  .lean()
  .exec(function(err, users) {
    console.log(users);
  });
```

#### Get total count of a field from all documents:
Let's suppose that each user has a `votes` field and you would like to count the total number of votes in your database accross all users. One very inefficient way would be to loop through each document and manually accumulate the count. Or you could use [MongoDB Aggregation Framework](http://docs.mongodb.org/manual/core/aggregation-introduction/) instead:
```js
User.aggregate({ $group: { _id: null, total: { $sum: '$votes' } } }, function(err, votesCount) {
  console.log(votesCount.total);
});
```

Contributing
------------

I agree with Sahat Yalkabov's contribution guide. This is an extremely opinionated project. Thus why I not only disconnected from his project, but completely rewrote 80% of the starter code. I wanted it to be in a form that I could get started with right away. It's not meant to be for everyone. Despite that, feel free to open an issue if you see something that you believe could be improved, and I'll give it the thumbs up or down for you to submit a pull request on it before you get started.

License
-------

The MIT License (MIT)

Copyright (c) 2014 Christopher WJ Rueber

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

Original codebase was licensed by Sahat Yalkabov in 2014 under the MIT License. No substantial portion of that code remains, but credit where it is due!