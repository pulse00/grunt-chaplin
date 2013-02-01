#! Path configuration for AMD.
require.config
  paths:
    # Collection of (extremely) useful utilities: <http://lodash.com/docs>.
    underscore: 'lib/underscore'

    # String manipulation extensions for underscore.
    'underscore-string': '../components/scripts/underscore.string/underscore.string'

    # Eases DOM manipulation.
    jquery: '../components/scripts/jquery/jquery'

    # Provides the JSON object for manipulation of JSON strings if not
    # already defined.
    json2: '../components/scripts/json3/json3'

    # Moment js, for date/time formatting
    moment: '../components/scripts/moment/moment'

    # Library that normalizes backbone and its extensions.
    backbone: 'lib/backbone'

    # Set of components and conventions powering Chaplin.
    'backbone-core': '../components/scripts/backbone/backbone'

    # Data binding utility library on top of backbone.
    'backbone-stickit': '../components/scripts/backbone.stickit/backbone.stickit'

    # handlebars library
    handlebars: '../components/scripts/handlebars/handlebars'

    # Micro-template directory.
    templates: '../templates'

    # Core framework powering the single-page application
    chaplin: 'vendor/chaplin'

  shim:
    'underscore-string':
      exports: '_.str'

    'handlebars':
      exports: 'Handlebars'

    'backbone-core':
      exports: 'Backbone'
      deps: [
        'jquery'
        'underscore'
        'json2'
      ]

    'backbone-stickit':
      deps: [
        'backbone-core'
      ]

#! Instantiates the application and begins the execution cycle.
require ['app'], (Application) ->
  new Application().initialize()
