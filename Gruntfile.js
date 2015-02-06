module.exports = function(grunt) {
  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),
    nodemon: {
      dev: {
        script: 'app.js',
        options: {
          // nodeArgs: ['--debug=5959'],
          watch: ['lib', 'controllers', 'config', 'models'],
          ext: 'js,coffee',
          env: { 
            PORT: 3000,
            SESSION_SECRET: 'meancoffee',
            MONGODB: "mongodb://localhost:27017/meanstart",
            REDISHOST: '127.0.0.1',
            REDISPORT: 6379,
            REDISAUTH: '',
            POSTGRESDB: 'pg://user:pass@localhost/skeleton',
            MAIL_HOST: '127.0.0.1',
            MAIL_PORT: 1025,
            MAIL_USERNAME: "user",
            MAIL_PASSWORD: "pass"
          }
        }
      }
    },
    concurrent: {
      dev: {
        tasks: ['nodemon'],
        options: {
          logConcurrentOutput: true
        }
      }
    }
  });

  grunt.loadNpmTasks('grunt-nodemon');
  grunt.loadNpmTasks('grunt-concurrent');

  grunt.registerTask('default', ['concurrent:dev']);
};