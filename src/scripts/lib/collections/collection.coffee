#! Extensions to `Chaplin.Collection` not merged into Chaplin for various
#! reasons.
#!
'use strict'

_        = require 'underscore'
Chaplin  = require 'chaplin'

#! Extends the chaplin collection, well; we'll leave it a that.
module.exports = class Collection extends Chaplin.Collection

  # Mixin a synchronization state machine.
  _(@::).extend Chaplin.SyncMachine

  #! Facilitating the sync machine.
  fetch: (options = {}) ->
    # Initiate a syncing operation; magic for selectors
    @beginSync()

    # Wrap callbacks so the sync machine is facilitated properly
    options.success = _.wrap options.success, (initial, params...) =>
      initial.call(this, params...) if initial?
      @finishSync()

    options.error = _.wrap options.error, (initial, params...) =>
      initial.call(this, params...) if initial?
      @abortSync()

    # Send the request down the pipes
    super options

  dispose: ->
    return if @disposed
    # Ends all syncing operations
    @unsync()
    super
