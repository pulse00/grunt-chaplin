#! Index controller.
'use strict'

Chaplin  = require 'chaplin'
View     = require 'views/index'

module.exports = class Index extends Chaplin.Controller
  show: ->
    @view = new View()
    @view.render()
