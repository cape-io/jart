fs = require 'fs'
yaml = require 'js-yaml'

should = require('chai').should()
jart = require('../jart')

data = yaml.safeLoad(fs.readFileSync(__dirname+'/data.yaml'))

describe '#jart', () ->
  it 'Filters array of items based on boxfan filter object. Performs pluck.', () ->
    jart(data.items, data.j_filter).should.eql(data.j_filter_result)
