(function () {
  if (typeof SnakeGame === "undefined") {
    window.SnakeGame = {};
  }
  
  var View = SnakeGame.View = function($el, size) {
    this.$el = $el;
    this.boardSize = size;
    this.board = new SnakeGame.Board($el, size);
    this.bindEvents();
    this.nextDir = "E";
    this.oldDir = "E";
    
    this.interval = setInterval(this.step.bind(this), 250);
  }
  
  View.prototype.bindEvents = function() {
    $('html').keydown(function(e) {
      this.oldDir = this.nextDir;
      switch(e.which) {
        case 38:
          this.nextDir = "W";
          break;
        case 39:
          this.nextDir = "N";
          break;
        case 40:
          this.nextDir = "E";
          break;
        case 37:
          this.nextDir = "S";
          break;
        default:
          return;
      }
    }.bind(this));
  }
  
  View.prototype.step = function() {
    // Out of bounds
    var newCoord = this.board.snake.segments[0].plus(this.nextDir);
    if (newCoord.x < 0 || newCoord.x == this.boardSize) {
      clearInterval(this.interval);
      alert("you lost!");
      return;
    } else if (newCoord.y < 0 || newCoord.y == this.boardSize) {
      clearInterval(this.interval);
      alert("you lost!");
      return;
    } 
    // Eating itself
    var eatingItself = false;
    this.board.snake.segments.forEach(function(segment) {
      if(segment.x === newCoord.x && segment.y === newCoord.y) {
        eatingItself = true;
      }
    })
    if(eatingItself) {
      clearInterval(this.interval);
      alert("you lost!");
      return;
    }
    
    var $food = this.board.css("[background='green']");
    if($food.length == 0) {
      this.placeFood();
    }
    
    this.board.snake.move(this.nextDir);
    this.board.render();
  }
  
  View.prototype.placeFood = function() {    
    var foodPos = [Math.floor(Math.random() * 15), Math.floor(Math.random() * 15)];
    
    if (~$('[data-row="' + foodPos[0] + '"][data-col="' + foodPos[1] + '"]').css('background').indexOf("rgb(255, 255, 255)")) {
      $('[data-row="' + foodPos[0] + '"][data-col="' + foodPos[1] + '"]').css('background', 'green');
    } else {
      //this.placeFood();
    }
  }
  
})();