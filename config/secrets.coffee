module.exports =
  sessionSecret: process.env.SESSION_SECRET or "meancoffestarter"
  email: 
    host: process.env.SMTP_HOST or '127.0.0.1'      # Mailcatcher defaults.
    port: process.env.SMTP_PORT or 1025
    user: process.env.SMTP_USER or "user"
    password: process.env.SMTP_PASSWORD or "pass"
  linkedin:
    clientID: process.env.LINKEDIN_ID or "75g87qt5xvqois"
    clientSecret: process.env.LINKEDIN_SECRET or "da0F5C3MH9eKXgim"
    callbackURL: "/auth/linkedin/callback"
    scope: [ "r_fullprofile", "r_emailaddress", "r_network" ]
    passReqToCallback: true
  google:
    clientID: process.env.GOOGLE_ID or "228531027374-nhgvmlmrc7bgsr7c0ptdai3u4vrdnbg1.apps.googleusercontent.com"
    clientSecret: process.env.GOOGLE_SECRET or "ZHU-mx904OKVjnDQRDGG6HdQ"
    callbackURL: "/auth/google/callback"
    passReqToCallback: true
