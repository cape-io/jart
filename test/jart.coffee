fs = require 'fs'
yaml = require 'js-yaml'

should = require('chai').should()
jart = require('../jart')

data = yaml.safeLoad(fs.readFileSync(__dirname+'/data.yaml'))

describe '#jart', () ->
  it 'Returns false when the item passed does not match filters', () ->
    jart(data.items[0], data.j_filter).should.be.false

  it 'Returns plucked field when the item passed filter.', () ->
    jart(data.items[3], data.j_filter).should.equal(4)

  it 'Filters array of items based on boxfan filter object. Performs pluck.', () ->
    jart(data.items, data.j_filter).should.eql(data.j_filter_result)
