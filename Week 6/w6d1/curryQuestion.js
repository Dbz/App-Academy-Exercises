function sum() {
  var args = Array.prototype.slice.call(arguments);
  var total = 0;
  args.forEach(function(num) {
    total += num;
  });
  return total;
}


Function.prototype.curry = function (numArgs) {
  var args = [];
  var that = this; // HERE
  function _curry(arg) {
    args.push(arg);
    
    if (args.length === numArgs) {
      return that.apply(null, args);
    } else {
      return _curry;
    }
  }
  
  return _curry;
}

var f1 = sum.curry(3);
var f2 = f1(1);
var f3 = f2(20);
var result = f3(-9);
console.log(result);

// versus

Function.prototype.curry = function (numArgs) {
  var args = [];
  
  var _curry = function (arg) {
    args.push(arg);
    
    if (args.length === numArgs) {
      return this.apply(null, args);
    } else {
      return _curry.bind(this);
    }
  }
  
  return _curry.bind(this); // HERE
}

var f1 = sum.curry(3);
var f2 = f1(1);
var f3 = f2(20);
var result = f3(-9);
console.log(result);