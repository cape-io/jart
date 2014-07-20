_ = require 'lodash'
_.str = require 'underscore.string'
_.mixin(_.str.exports())

module.exports =

  model: (items, info) ->
    if _.isArray items
      # Add fields to items before filter.
      items = _.map items, (item) =>
        # Send each item through the modifiers.
        return @model item, info
      # Remove the junk we don't want.
      if info.filter
        items = _.filter items, (item) =>
          @filter item, info.filter
        if info.without
          items = @without items, info.without
      return items

    unless _.isObject items
      return items

    return @_model items, info

  _model: (items, info) ->
    # Remove the path prefix from the primary key.
    if info.arg and info.arg.path_prefix and info.primary_key and items[info.primary_key]
      items[info.primary_key] = @rm_prefix items[info.primary_key], info.arg.path_prefix
    if info.pluck
      items = @pluck items, info.pluck
    if info.default
      items = _.defaults items, info.default
    if info.field
      items = @field items, info.field, info.primary_key
    if info.fields
      items = @field items, info.fields, info.primary_key
    if info.without and not info.filter
      items = @without items, info.without
    if info.rename
      items = @rename items, info.rename
    # emit?
    if info.clean
      items = @clean items

  rm_prefix: (full_str, prefix, strip_slash = true) ->
    #return _.str.ltrim full_str, prefix # <- too greedy
    if full_str.substring(0, prefix.length) == prefix
      full_str = full_str.substring(prefix.length)
      if strip_slash and '/' == full_str.substring 0, 1
        full_str = full_str.substring 1
    return full_str

