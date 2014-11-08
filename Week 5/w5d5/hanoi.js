var readline = require("readline");

var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

function HanoiGame() {
  this.stacks = [[1, 2, 3],[],[]];
}

HanoiGame.prototype.isWon = function() {
  if(this.stacks[2].length == 3 || this.stacks[1].length == 3){
    return true;
  }
  return false;
}

HanoiGame.prototype.isValidMove = function(startTowerIdx, endTowerIdx) {
  if(this.stacks[endTowerIdx].length == 0) {
    return true;
  }
  else if(this.stacks[startTowerIdx][0] < this.stacks[endTowerIdx][0]) {
    return true;
  }
  return false;
}

HanoiGame.prototype.move = function(start, end) {
  if(this.isValidMove(start, end)) {
    var piece = this.stacks[start].shift();
    this.stacks[end].unshift(piece);
    return true;
  }
  return false;
}

HanoiGame.prototype.print = function() {
  this.stacks.forEach(function(stack) {
    console.log(JSON.stringify(stack))
  });
}

HanoiGame.prototype.promptMove = function(callback) {
  this.print();
  reader.question("Which stack would you like to move from?", function(first) {
    first = parseInt(first);
    reader.question("Which stack would you like to move to?", function(sec) {
      sec = parseInt(sec);
      callback(first, sec);
    });
  });
}

HanoiGame.prototype.run = function(completionCallback) {
  this.promptMove(function(first, second) {
    if(this.isValidMove(first, second)) {
      this.move(first, second);
    } else {
      console.log("That was not a valid move. Try again");
    }
    if(this.isWon()) {
      console.log("Yay! You won!!!! Awesome job! Hooray!");
      reader.close();
      return;
    }
    this.run();
  }.bind(this));
}

var game = new HanoiGame();
game.run();
