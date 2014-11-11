function sum() {
  var args = Array.prototype.slice.call(arguments);
  var total = 0;
  args.forEach(function(num) {
    total += num;
  });
  return total;
}

function mybind(context) {
  var args = Array.prototype.slice.call(arguments);
  var fn = context;
  return function() {
    fn.apply(context, args.slice(1));
  }
}

function curriedSum(numArgs) {
  var numbers = [];
  
  function _curriedSum(num) {
    numbers.push(num);
    if(numbers.length == numArgs) {
        var sum = 0;
        
        numbers.forEach(function (arg) {
          sum += arg;
        });
        
        return sum;
    } else {
      return _curriedSum;
    }
  }
  return _curriedSum
}

// var f1 = curriedSum(3);
// var f2 = f1(1);
// var f3 = f2(20);
// var result = f3(-9);
// console.log(result);

Function.prototype.curry = function (numArgs) {
  var args = [];
  var that = this;
  function _curry(arg) {
    args.push(arg);
    
    if (args.length == numArgs) {
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
