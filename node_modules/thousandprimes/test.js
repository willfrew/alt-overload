'use strict';

var assert = require('assert');
var primes = require('./');

describe('primes', function(){
	it('is an array', function(){
		assert.ok(primes instanceof Array);
	});
});

describe('primes[0]', function(){
	it('is 2', function(){
		assert.equal(primes[0], 2);
	});
});

describe('primes[999]', function(){
	it('is 7919', function(){
		assert.equal(primes[999], 7919);
	});
});
