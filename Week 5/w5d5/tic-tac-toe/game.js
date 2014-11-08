var Board = require("./board");
var readline = require("readline");

var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

function Game() {
  this.board = new Board();
  this.mark = 1;
}

Game.prototype.play = function() {
  this.board.print();

  this.getPosition(function(pos) {
    if (this.board.isEmpty(pos)) {
      this.board.placeMark(pos, this.markLetter());
      this.mark = (this.mark === 0 ? 1 : 0);
    } else {
      console.log("That was not a valid position\n");
      this.play();
      return;
    }
    
    if(this.board.isWon()) {
      this.printWinner();
      return;
    }
    
    this.play();
  }.bind(this));
}

Game.prototype.markLetter = function () {
  return Board.MARKS[this.mark];
}

Game.prototype.printWinner = function(){
  this.board.print();
  console.log("Winner is player " + this.board.winner());
  reader.close();
}

Game.prototype.getPosition = function(callback) {
  reader.question("Please pick a position", function(ans) {
    ans = parseInt(ans);
    var x = Math.ceil(ans/3) - 1;
    var y = (ans % 3) - 1;
    y = (y == -1 ? 2 : y); 
    var pos = [x, y];
    callback(pos);
  });
}

module.exports = Game;