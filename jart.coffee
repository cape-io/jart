_ = require 'lodash'
boxfan = require 'boxfan'

module.exports =

# @cape `without` should probably include _self

  model: (items, info) ->
    if _.isArray items
      # Add fields to items before filter.
      items = _.map items, (item) =>
        # Send each item through the modifiers.
        return @model item, info

      # Remove the junk we don't want.
      if info.filter
        items = boxfan items, info.filter

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


