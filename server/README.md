

Recommended Libraries and Tools
-------------------------------

- [Node Inspector](https://github.com/node-inspector/node-inspector) - Node.js debugger based on Chrome Developer Tools.
- [Filesize.js](http://filesizejs.com/) - Pretty file sizes, e.g. `filesize(265318); // "265.32 kB"`.
- [Numeral.js](http://numeraljs.com) - Library for formatting and manipulating numbers.
- [Moment.js](http://momentjs.com/) - Date parsing library.
- [Node-UUID](https://github.com/broofa/node-uuid) - RFC 4122 UUID Generator
- [Cheerio](https://github.com/cheeriojs/cheerio) - For scraping sites.
- [got](https://www.npmjs.com/package/got) - Making HTTP requests.


NodeJS Pro Tips
--------

- Use `yarn` for all package changes, which makes sure that packages end up in the package.json file by default.
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
- Copy and paste *Client ID* and *Client secret* keys into `config/oauth_keys.js`

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
- Copy and paste *API Key* and *Secret Key* keys into `config/oauth_keys.js`
 - *API Key* is your **clientID**
 - *Secret Key* is your **clientSecret**

<hr>

