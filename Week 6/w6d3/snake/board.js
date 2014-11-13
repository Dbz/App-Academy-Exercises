(function () {
  if (typeof SnakeGame === "undefined") {
    window.SnakeGame = {};
  }
  
  var Board = SnakeGame.Board = function($el, size) {
    this.$el = $el;
    this.snake = new SnakeGame.Snake([Math.floor(size/2), Math.floor(size/2)]);    
    this.makeBoard(size);
    this.render();
    this.food;
  }
  
  Board.prototype.makeBoard = function(size) {
    var str = "";
    for(var i = 0; i < size; i++) {
      for(var j = 0; j < size; j++) {
        str += "<div class='tile' data-row='" + i + "' data-col='" + j + "'></div>";
      }
    }
    this.$el.append(str);
  }
  
  Board.prototype.render = function() {
    var head = this.snake.segments[0];
    $('[data-row="' + head.x + '"][data-col="' + head.y + '"]').css('background', 'orange');
    
    this.snake.segments.slice(1).forEach(function(coord) {
      var piece = $('[data-row="' + coord.x + '"][data-col="' + coord.y + '"]');
      piece.css('background', 'cadetblue');
    });
  }
})();