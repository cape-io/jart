fs = require 'fs'
yaml = require 'js-yaml'
_ = require 'understory'

should = require('chai').should()
jart = require('../jart')

data = yaml.safeLoad(fs.readFileSync(__dirname+'/data.yaml'))

describe '#jart', () ->
  it 'Returns false when the item passed does not match filters', () ->
    jart(data.items[0], data.j_filter).should.be.false

  it 'Returns plucked field when the item passed filter.', () ->
    jart(data.items[3], data.j_filter).should.equal(4)

  it 'Filters array of items based on boxfan filter object. Performs pluck.', () ->
    items = _.clone(data.items)
    jart(items, data.j_filter).should.eql(data.j_filter_result)

  it 'Processes field, fields, default, rename correctly.', () ->
    items = _.clone(data.items)
    jart(items, data.j_info).should.eql(data.j_info_result)
