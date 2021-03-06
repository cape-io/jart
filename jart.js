(function() {
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
      item = prairie(item, info.field, info.primary_key);
    }
    if (info.fields) {
      item = fields(item, info);
    }
    if (_.isObject(info["default"])) {
      item = _.defaults(item, info["default"]);
    }
    if (_.isObject(info.rename)) {
      item = _.rename(item, info.rename);
    }
    return item;
  };

  fields = function(item, info) {
    _.each(info.fields, function(field_info) {
      if (_.isObject(field_info.field)) {
        if (_.isObject(field_info.filter)) {
          if (boxfan(item, field_info.filter)) {
            item = model(item, field_info, info);
          }
        } else {
          item = model(item, field_info, info);
        }
      }
    });
    return item;
  };

  land = function(item, info) {
    if (info.pluck) {
      item = _.pluck(item, info.pluck);
    }
    if (info.without) {
      item = _.without(item, info.without);
    }
    if (info.clean) {
      item = _.clean(item);
    }
    return item;
  };

  module.exports = function(items, info) {
    var return_items;
    if (!_.isObject(info)) {
      return items;
    }
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

}).call(this);
