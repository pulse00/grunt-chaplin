#! Extensions to `Chaplin.Model` not merged into Chaplin for various
#! reasons.
#!
'use strict'

Chaplin = require 'chaplin'

#! Extends the chaplin model, well; we'll leave it a that.
module.exports = class Model extends Chaplin.Model

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
