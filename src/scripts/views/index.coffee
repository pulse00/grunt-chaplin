'use strict'

View = require 'lib/views/view'

module.exports = class Index extends View

  template: ->
    t = require 'templates/index'
    return t['src/templates/index.hbs']
