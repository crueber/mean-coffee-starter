module.exports = function(grunt) {
  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),
    nodemon: {
      dev: {
        script: 'app.js',
        options: {
          nodeArgs: ['--debug=5858'],
          watch: ['lib', 'controllers', 'config', 'models'],
          ext: 'js,coffee',
          env: { 
            PORT: '3100'
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

  grunt.registerTask('default', ['concurrent']);
};