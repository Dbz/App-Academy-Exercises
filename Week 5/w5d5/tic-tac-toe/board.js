
function Board() {
  this.grid = [["1", "2", "3"], ["4", "5", "6"], ["7", "8", "9"]];
}

Board.MARKS = ["X", "O"];

Board.prototype.isWon = function() {
  if(this.winner() === false){
    return false;
  }
  return true;
}

Board.prototype.winner = function() {
  var winningMark = "";

  for(var r = 0; r < 3; r++) { // Each Row
    for(var c = 0; c < 3; c++) { // Each Col
      mark = this.searchForWinner(r, c);
      if(~Board.MARKS.indexOf(mark)) {
        return mark;
      }
    }
  }
  return false;
}

Board.prototype.searchForWinner = function(r, c) {
  var directions = [[1,0], [0,1], [1, 1], [1, -1]];
  var winningMark = false
  directions.forEach(function (dir) {
    if(r + 2 * dir[0] > 2 || c + 2 * dir[1] > 2) { // Off Grid
      return;
    }
    mark = this.checkForWin(r, c, dir);
    if(~Board.MARKS.indexOf(mark)) {
      winningMark = mark;
    }
    
  }.bind(this));
  return winningMark;
}

Board.prototype.checkForWin = function(r, c, dir) {
  winningMark = false
  Board.MARKS.forEach(function(mark) {
    var allSameMark = true
    for(var j = 0; j < 3; j++) {  // Each position has mark
      if(this.grid[r + dir[0] * j][c + dir[1] * j] != mark) {
        allSameMark = false;
      }
    }
    if(allSameMark) {
      winningMark = mark;
    }
  }.bind(this));
  return winningMark;
}

Board.prototype.isEmpty = function(pos) {
  if(this.grid[pos[0]][pos[1]] == Board.MARKS[0])
    return false;
  if(this.grid[pos[0]][pos[1]] == Board.MARKS[1])
    return false;
  return true;
}

Board.prototype.placeMark = function(pos, mark) {
  var x = pos[0];
  var y = pos[1];
  this.grid[x][y] = mark;
}

Board.prototype.print = function() {
  var str = [];
  this.grid.forEach(function(row) {
    str.push(row[0] + "|" + row[1] + "|" + row[2]);
  });
  console.log(str.join("\n-----\n"));
}

module.exports = Board;