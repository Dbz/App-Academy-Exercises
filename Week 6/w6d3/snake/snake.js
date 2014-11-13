(function () {
  if (typeof SnakeGame === "undefined") {
    window.SnakeGame = {};
  }
  
  var Snake = SnakeGame.Snake = function(initialPosition) {
    this.dir = "W";
    this.segments = [new Coord(initialPosition)];
  }
  
  var Coord = function(pos) {
    this.x = pos[0];
    this.y = pos[1];
  }
  
  Coord.prototype.plus = function(dir) {
    switch(dir) {
      case "N":
        return new Coord([this.x, this.y + 1]);
        break;
      case "S":
        return new Coord([this.x, this.y - 1]);
        break;
      case "E":
        return new Coord([this.x + 1, this.y]);
        break;
      case "W":
        return new Coord([this.x - 1, this.y]);
        break;
    }
  };
  
  Snake.prototype.move = function(dir) {
    var piece = this.segments[0].plus(dir);
    this.segments.unshift(piece);
    
    this.segments.forEach(function(seg) {
      seg.plus();
    })
    // We don't eat food then pop and recolor background
    if(!$('[data-row="' + piece.x + '"][data-col="' + piece.y + '"]').css('background') == 'green') {
      var temp = this.segments.pop();
      $('[data-row="' + temp.x + '"][data-col="' + temp.y + '"]').css('background', 'white');
    }
  }
  
  
  Snake.prototype.turn = function(dir) {
    this.dir = dir;
  }
})();
    