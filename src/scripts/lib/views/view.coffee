#! Extensions to `Chaplin.View` not merged into Chaplin for various
#! reasons.
#!
'use strict'

_       = require 'underscore'
Chaplin = require 'chaplin'

#! Extends the chaplin view, well; we'll leave it a that.
module.exports = class View extends Chaplin.View

  #! Default container.
  container: '#container'

  #! Boolean indicating if we are `stuck` through stickit
  _stuck: false

  #! Just forwards `@template` through `@getTemplateFunction` as
  #! the template has been precompiled by HAML.
  getTemplateFunction: -> @template

  stickit: ->
    super
    @_stuck = true

  afterRender: ->
    super

    # Perform a default stickit unless it has been explicitly called
    @stickit() unless @_stuck

    # In case we are rendered again we should be `stuck` again
    @_stuck = false

    # Render all bound subviews
    subview.render() for name, subview of @subviewsByName

  dispose: ->
    return if @disposed
    # Delete stickit bindings
    @unstickModel()
    super
