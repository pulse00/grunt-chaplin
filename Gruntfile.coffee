module.exports = (grunt) ->

  # Underscore
  # ==========
  _ = grunt.util._

  # Package
  # =======
  pkg = require './package.json'

  # Grunt
  # =====
  grunt.initConfig

    # Cleanup
    # -------
    clean:
      build: 'build'
      temp: 'temp'
      bower: 'components'
      components: 'src/components'

    # Wrangling
    # ---------
    copy:
      options:
        excludeEmpty: true

      module:
        files: [
          dest: 'temp/scripts'
          cwd: 'temp/scripts:amd'
          expand: true
          src: [
            '**/*'
            '!main.js'
            '!vendor/**/*'
          ]
        ]

      static:
        files: [
          dest: 'temp'
          cwd: 'src'
          expand: true
          src: [
            '**/*'
            '!*.{coffee,scss,hbs}'
          ]
        ]

      build:
        files: [
          # Any files in root; index, robots, etc.
          # Any built style files.
          dest: 'build/'
          cwd: 'temp'
          expand: true
          src: [
            '*',
            'styles/**/*.css',
            'media/**/*'
          ]
        ,
          # Modernizer is loaded before we boot into require; so it is outside
          # of the mega-js file.
          dest: 'build/components/scripts/modernizr/modernizr.js'
          cwd: 'temp'
          expand: true
          src: 'components/scripts/modernizr/modernizr.js'
        ]

    # Compilation
    # -----------
    coffee:
      compile:
        files: [
          dest: 'temp/scripts/'
          src: '**/*.coffee'
          cwd: 'src/scripts'
          ext: '.js'
          expand: true
        ]

        options:
          bare: true

    # Dependency management
    # ---------------------
    bower:
      install:
        options:
          targetDir: './src/components'
          cleanup: true
          install: true

    # Module conversion
    # -----------------
    urequire:
      AMD:
        bundlePath: 'temp/scripts/'
        outputPath: 'temp/scripts:amd/'

    # Templates
    # ---------

    handlebars:
      compile:
        options:
          amd: true
        files: [
          dest: 'temp/templates/'
          cwd: 'src/templates'
          ext: '.js'
          expand: true
          src: '**/*.hbs'
        ]

    # Stylus
    # -------
    stylus:
      compile:
        files: 'temp/styles/main.css': ['src/styles/**/*.styl']

    # Watch
    # -----
    watch:
      coffee:
        files: 'src/scripts/**/*.coffee'
        tasks: 'script'
        options:
          interrupt: true


      stylus:
        files: 'src/styles/**/*.styl'
        tasks: 'stylus:compile'
        options:
          interrupt: true

    # Lint
    # ----
    coffeelint:
      gruntfile: 'Gruntfile.coffee'
      src: 'src/**/*.coffee'

    # Dependency tracing
    # ------------------
    requirejs:
      compile:
        options:
          out: 'build/scripts/main.js'
          include: _(grunt.file.expandMapping(['main*', 'controllers/**/*'], ''
            cwd: 'src/scripts/'
            rename: (base, path) -> path.replace /\.coffee$/, ''
          )).pluck 'dest'
          mainConfigFile: 'temp/scripts/main.js'
          baseUrl: './temp/scripts'
          keepBuildDir: true
          preserveLicenseComments: false


    # Webserver
    # ---------
    connect:
      server:
        options:
          base: 'temp'
          hostname: 'localhost'
          port: 3501

  # Dependencies
  # ============
  for name, version of pkg.devDependencies
    if name.substring(0, 6) is 'grunt-'
      grunt.loadNpmTasks name

  # Tasks
  # =====

  # Prepare
  # -------
  grunt.registerTask 'prepare', [
    'bower:install'
  ]

  # Script
  # ------
  grunt.registerTask 'script', [
    'coffee:compile'
    'urequire'
    'copy:module'
  ]

  # Lint
  # ----
  grunt.registerTask 'lint', [
    'coffeelint'
  ]

  # Default
  # -------
  grunt.registerTask 'default', [
    'prepare'
    'script'
    'handlebars:compile'
    'stylus:compile'
    'connect'
    'watch'
  ]

  # Build
  # -----
  grunt.registerTask 'build', [
    'prepare'
    'copy:static'
    'script'
    'handlebars:compile'
    'stylus:build'
    'requirejs:compile'
    'copy:build'
  ]
