function uniq(array){
  array.forEach(function(num){
    if(array.indexOf(num) !== array.lastIndexOf(num)){
      array.splice(array.lastIndexOf(num), 1);
    }
  });
  return array
}
// console.log(uniq([5,5,5,3,2,2]))

function twoSum(arr) {
  var pairs = []
  for(var i =0; i < arr.length; i++) {
    if(~arr.slice(i).indexOf(arr[i] * -1) && 
    i != i + arr.slice(i).indexOf(arr[i] * -1))
    pairs.push([i, i + arr.slice(i).indexOf(arr[i] * -1)])
  }
  return pairs
}

// console.log(twoSum([-2, 0, 1, 2, -1, -2, 5]))



function myTranspose(arr) {
  transposed = new Array(arr.length)
  for(var i = 0; i < arr.length; i++){
    transposed[i] = new Array(arr.length)
  }
  
  for(var i = 0; i < arr.length; i++) {
    for(var j = 0; j < arr[i].length; j++) {
      transposed[i][j] = arr[j][i]
    }
  }
  return transposed
}

// console.log(myTranspose([[1,2,3],[4,5,6],[7,8,9]]))

function doubleArray(arr) {
  for(var i=0; i < arr.length; i++) {
    arr[i] *= 2
  }
  return arr
}

// console.log(doubleArray([1,2,3]))


Array.prototype.myEach = function(callback) {
  for(var i = 0; i < this.length; i++){
    callback(this[i])
  }
  return this
}

// console.log([1,2,3].myEach(function(num) { return num * 2 }))

Array.prototype.myMap = function(callback) {
  results = [];
  
  this.myEach(function(el){
    results.push(callback(el))
  })
  return results;
}

// console.log([1,2,3].myMap(function(num) { return num = num * 2 }))

Array.prototype.myInject = function(callback) {
  var count = 0
  this.myEach(function(el){
    count = callback(count, el)
  })
  
  return count
}


// console.log([1,2,3].myInject(function(memo, num) { return memo + num * 2 }))


Array.prototype.bubbleSort = function() {
  for(var i = 0; i < this.length; i++) {
    for(var j = i + 1; j < this.length; j++ ) {
      if(this[j] > this[i]) {
        this[j] = this[j]^this[i]
        this[i] = this[j]^this[i]
        this[j] = this[j]^this[i]
      }
    }
  }
  return this
}

// console.log([3,5,2,6,4,1].bubbleSort())



String.prototype.substrings = function() {
  var substrings = []
  for(var i = 0; i < this.length; i++) {
    for(var j = i; j < this.length; j++ ) {
      substrings.push(this.slice(i, j + 1))
    }
  }
  return uniq(substrings)
}

// console.log("Hello".substrings())

function range(start, end) {
  if(end < start) {
    return
  } else if(start == end) {
    return [end]
  }
  var nums = range(start + 1, end)
  return [start] + [nums]
}

// console.log(range(7, 34))

function exp1(b, n) {
  if(n == 0)
  return 1
  return b * exp1(b, n -1)
}

// console.log(exp1(2, 4))

function exp2(b, n) {
  if(n == 0)
  return 1
  if(n % 2 == 0) {
    var temp = exp2(b, (n) / 2)
    return temp * temp
  } else {
    var temp = exp2(b, (n - 1) / 2)
    return temp * temp * b
  }
}

// console.log(exp2(-3, 3))

function fibonacci(num) {
  if(num == 1)
  return [0]
  if(num == 2)
  return [0, 1]
  var fib = fibonacci(num - 1)
  fib.push(fib[fib.length - 1] + fib[fib.length - 2])
  return fib
}

// console.log(fibonacci(20))

function binarySearch(arr, target) {
  var middle = Math.floor(arr.length / 2)
  var leftArray = arr.slice(0, middle)
  var rightArray = arr.slice(middle)
    
  if(arr[middle] == target){
    return middle
  } else if(arr[middle] > target) {
    return binarySearch(leftArray, target)
  } else {
    return middle + binarySearch(rightArray, target)
  }
}

// console.log(binarySearch([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15], 5))

function smallerArr(arr1, arr2) {
  
  //we want to return the shortest non empty array
  if(arr1.length == 0) {
    return arr2;
  } else if (arr2.length == 0) {
    return arr1;
  }
  
  if (arr1.length < arr2.length){
    return arr1;
  } else {
    return arr2;
  }
  
}

function makeChange(num, coins) {
  var amount = num
  if(coins.length == 0) {
    return [];
  }
  var change = [] 
  coins.forEach(function(coin) {
    while(coin <= amount) {
      change.push(coin)
      amount -= coin
    }
  })
  // console.log(change)
  return smallerArr(change, makeChange(num, coins.slice(1)))
}

// console.log(makeChange(14, [10,7, 1]))


Array.prototype.merge = function(arr2) {
  var merged = []
  
  while(this.length != 0 && arr2.length != 0) {
    if(this[0] < arr2[0]){
      merged.push(this.shift());
    } else {
      merged.push(arr2.shift());
    }
  }
  return merged.concat(this).concat(arr2);
}

Array.prototype.mergeSort = function() {
  if (this.length <= 1) {
    return this;
  }
  var middle = Math.floor(this.length / 2);
  var left = this.slice(0, middle);
  var right = this.slice(middle);
  
  return left.mergeSort().merge(right.mergeSort());
}

// console.log([6,8,2,4,5,3,43,4,5,45,6,7,7,1,3,100].mergeSort())

Array.prototype.subsets = function() {
  if(this.length == 0){
    return [[]]
  }
  var current = this.shift()
  var sets = this.slice(0).subsets()
  sets.forEach(function(sub) {
    sub.push(current)
  })
  // console.log(sets)
  sets = sets.concat(this.subsets())
  return sets
}

// console.log([1, 2, 3].subsets())


