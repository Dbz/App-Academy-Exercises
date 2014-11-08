var readline = require('readline');

var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

function addNumbers (sum, numsLeft, callback) {
  reader.question("What number would you like to add?", function(n) {
    numsLeft -= 1
    sum += parseInt(n);
    callback(sum);
    if(numsLeft == 0) {
      reader.close();
      return;
    }
    addNumbers(sum, numsLeft, callback);
  });
}


addNumbers(0, 3, function (sum) {
  console.log("Total Sum: " + sum);
});