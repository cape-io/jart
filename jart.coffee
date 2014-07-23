_ = require 'understory'
boxfan = require 'boxfan'
prairie = require 'prairie'

# @cape
# `without` should probably include _self
# 'path_prefix' should be in field.

model = (item, info) ->
  # Remove the path prefix from the primary key.
  # if info.arg and info.arg.path_prefix and info.primary_key and items[info.primary_key]
  #   items[info.primary_key] = @rm_prefix items[info.primary_key], info.arg.path_prefix

  # Add prairie fields to item object.
  if info.field
    item = prairie item, info.field, info.primary_key

  # Array of Prairie object fields inside the `field` prop.
  if info.fields
    fields item, info.fields

  if _.isObject info.default
    item = _.defaults item, info.default

  if _.isObject info.rename
    item = _.rename item, info.rename

  if info.clean
    item = _.clean item

  if info.pluck
    item = _.pluck item, info.pluck
  else if info.without
    item = _.without item, info.without
  return

fields = (item, fields_obj) ->
  _.each fields_obj, (field_info) ->
    if _.isObject(field_info.field)
      # Mostly this is to apply fields conditionally.
      if _.isObject(field_info.filter)
        # Only process field if passes check.
        if boxfan(item, info.filter)
          item = prairie item, field_info.field, info.primary_key
      # No filter prop.
      else
        item = prairie item, field_info.field, info.primary_key
    return
  return

module.exports = (items, info) ->
  if _.isArray items
    # Add fields to items before filter.
    items = _.map items, (item) =>
      # Send each item through the modifiers.
      return model item, info

    # Remove the junk we don't want.
    if info.filter
      items = boxfan items, info.filter

    return items
  else if _.isObject items
    return model items, info
  else
    return items
