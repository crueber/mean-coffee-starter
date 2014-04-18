module.exports = function(grunt) {
  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),
    nodemon: {
      dev: {
        script: 'app.js',
        options: {
          nodeArgs: ['--debug=5858'],
          ignoredFiles: ['node_modules/**', 'views/**', '.git/**', 'public/**', 'Gruntfile.js'],
          env: { 
            PORT: '3000'
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