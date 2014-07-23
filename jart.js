// Generated by CoffeeScript 1.6.3
var boxfan, fields, land, model, prairie, toss, _;

_ = require('understory');

boxfan = require('boxfan');

prairie = require('prairie');

toss = function(item, info) {
  item = model(item, info);
  if (info.filter) {
    if (!boxfan(item, info.filter)) {
      item = false;
      return item;
    }
  }
  item = land(item, info);
  return item;
};

model = function(item, info) {
  if (info.field) {
    console.log('field');
    item = prairie(item, info.field, info.primary_key);
  }
  if (info.fields) {
    console.log('fields');
    item = fields(item, info.fields);
  }
  if (_.isObject(info["default"])) {
    console.log('default');
    item = _.defaults(item, info["default"]);
  }
  if (_.isObject(info.rename)) {
    console.log('rename');
    item = _.rename(item, info.rename);
  }
  return item;
};

land = function(item, info) {
  if (info.pluck) {
    item = _.pluck(item, info.pluck);
  } else if (info.without) {
    item = _.without(item, info.without);
  }
  if (info.clean) {
    item = _.clean(item);
  }
  return item;
};

fields = function(item, fields_obj) {
  _.each(fields_obj, function(field_info) {
    if (_.isObject(field_info.field)) {
      if (_.isObject(field_info.filter)) {
        if (boxfan(item, info.filter)) {
          item = prairie(item, field_info.field, info.primary_key);
        }
      } else {
        item = prairie(item, field_info.field, info.primary_key);
      }
    }
  });
};

module.exports = function(items, info) {
  var return_items;
  if (_.isArray(items)) {
    return_items = [];
    _.each(items, function(item, i) {
      item = toss(item, info);
      if (item) {
        return_items.push(item);
      }
      return delete items[i];
    });
    return return_items;
  } else if (_.isObject(items)) {
    return toss(items, info);
  } else {
    return items;
  }
};
