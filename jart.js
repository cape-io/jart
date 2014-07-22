// Generated by CoffeeScript 1.6.3
var boxfan, _;

_ = require('lodash');

boxfan = require('boxfan');

module.exports = {
  model: function(items, info) {
    var _this = this;
    if (_.isArray(items)) {
      items = _.map(items, function(item) {
        return _this.model(item, info);
      });
      if (info.filter) {
        items = boxfan(items, info.filter);
      }
      return items;
    }
    if (!_.isObject(items)) {
      return items;
    }
    return this._model(items, info);
  },
  _model: function(items, info) {
    if (info.arg && info.arg.path_prefix && info.primary_key && items[info.primary_key]) {
      items[info.primary_key] = this.rm_prefix(items[info.primary_key], info.arg.path_prefix);
    }
    if (info.pluck) {
      items = this.pluck(items, info.pluck);
    }
    if (info["default"]) {
      items = _.defaults(items, info["default"]);
    }
    if (info.field) {
      items = this.field(items, info.field, info.primary_key);
    }
    if (info.fields) {
      items = this.field(items, info.fields, info.primary_key);
    }
    if (info.without && !info.filter) {
      items = this.without(items, info.without);
    }
    if (info.rename) {
      items = this.rename(items, info.rename);
    }
    if (info.clean) {
      return items = this.clean(items);
    }
  }
};
