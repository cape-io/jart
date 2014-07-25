_ = require 'understory'
boxfan = require 'boxfan'
prairie = require 'prairie'

# @cape
# `without` should probably include _self
# 'path_prefix' should be in field.

# Proccess a jart for a single entity.
toss = (item, info) ->
  # Add fields to items before filter.
  item = model item, info
  if info.filter
    # Filter down the result.
    unless boxfan item, info.filter
      item = false
      return item
  # Clean it off.
  item = land item, info
  return item

# Toss the jart over the fields.
model = (item, info) ->
  # Remove the path prefix from the primary key.
  # if info.arg and info.arg.path_prefix and info.primary_key and items[info.primary_key]
  #   items[info.primary_key] = @rm_prefix items[info.primary_key], info.arg.path_prefix
  #console.log item
  # Add prairie fields to item object.
  if info.field
    #console.log 'field'
    item = prairie item, info.field, info.primary_key
  # Array of Prairie object fields inside the `field` prop.
  if info.fields
    #console.log 'fields'
    item = fields item, info

  if _.isObject info.default
    #console.log 'default'
    item = _.defaults item, info.default

  if _.isObject info.rename
    #console.log 'rename'
    item = _.rename item, info.rename

  return item

fields = (item, info) ->
  #console.log item
  _.each info.fields, (field_info) ->
    # Only do stuff when it has a field property.
    if _.isObject(field_info.field)
      # Mostly this is to apply fields conditionally.
      if _.isObject(field_info.filter)
        # Only process field if passes check.
        if boxfan(item, field_info.filter)
          item = prairie item, field_info.field, info.primary_key
      # No filter prop.
      else
        item = prairie item, field_info.field, info.primary_key
    return
  #console.log item
  return item

# Remove the junk we don't want.
land = (item, info) ->
  if info.pluck
    item = _.pluck item, info.pluck

  if info.without
    item = _.without item, info.without

  if info.clean
    item = _.clean item

  return item

module.exports = (items, info) ->
  unless _.isObject info
    return items
  if _.isArray items
    return_items = []
    _.each items, (item, i) ->
      item = toss item, info
      if item
        return_items.push item
      delete items[i]
    return return_items
  else if _.isObject items
    return toss items, info
  else
    return items
