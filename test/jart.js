// Generated by CoffeeScript 1.6.3
var data, fs, jart, should, yaml;

fs = require('fs');

yaml = require('js-yaml');

should = require('chai').should();

jart = require('../jart');

data = yaml.safeLoad(fs.readFileSync(__dirname + '/data.yaml'));

describe('#jart', function() {
  return it('Filters array of items based on boxfan filter object. Performs pluck.', function() {
    return jart(data.items, data.j_filter).should.eql(data.j_filter_result);
  });
});
