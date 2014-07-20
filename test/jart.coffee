should = require('chai').should()
jart = require('../jart')

rm_prefix = jart.rm_prefix
describe '#rm_prefix', () ->
  it 'Removes a string from the left of another. Removes leading slash by default.', () ->
    rm_prefix('/some/long/path', '/some').should.equal('long/path')
  it 'Only remove subject string. Not leading slash', () ->
    rm_prefix('/some/long/path', '/some', false).should.equal('/long/path')