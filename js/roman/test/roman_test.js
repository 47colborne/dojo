'use strict';
var expect = require('chai').expect;
var roman = require('../roman');

describe('decimal to roman numerals', function () {

  it('should return I for 1', function() {
    expect(roman().translate(1)).to.eq('I');
  });

  it('should return II for 2', function() {
    expect(roman().translate(2)).to.eq('II');
  });

  it('should return V for 5', function() {
    expect(roman().translate(5)).to.eq('V');
  });

  it('should return IV for 4', function() {
    expect(roman().translate(4)).to.eq('IV');
  });

  it('should return IX for 9', function(){
    expect(roman().translate(9)).to.eq('IX');
  });

  it('should return XIV for 14', function(){
    expect(roman().translate(14)).to.eq('XIV');
  });

  it('should return DCCXLIV for 744', function(){
    expect(roman().translate(744)).to.eq('DCCXLIV');
  });

  it('should return DIX for 509', function(){
    expect(roman().translate(509)).to.eq('DIX');
  });

  it('should return nothing for 0', function(){
    expect(roman().translate(0)).to.eq('');
  });

  it('should not try to evaluate any number higher than 3999', function(){
    expect(roman().translate(4000)).to.eq(undefined);
  });

  it('should return MMMCMXCIX for 3999', function(){
    expect(roman().translate(3999)).to.eq('MMMCMXCIX');
  });
});
