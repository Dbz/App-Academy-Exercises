(function () {
  if (typeof TTT === "undefined") {
    window.TTT = {};
  }

  var View = TTT.View = function ($el) {
    this.$el = $el;
    this.game = new TTT.Game;
    this.setupBoard();
    this.bindEvents();
    this.colorIndex = 0;
  };
  
  View.COLORS = ['red', 'blue'];
  
  View.prototype.bindEvents = function () {
    $(".cell").on('click', this.makeMove.bind(this));
  };

  View.prototype.makeMove = function (event) {
    var cell = $(event.currentTarget);
    if (~cell.css('background').indexOf('rgb(255, 255, 255)') && !this.game.isOver()) {
      var row = cell.data('row');
      var col = cell.data('col');
      this.game.playMove([row, col]);
      cell.css('background', View.COLORS[this.colorIndex]);
      this.colorIndex = this.colorIndex ? 0 : 1;
    }
    if(this.game.isOver()) {
      var winner = this.game.winner();
      if(winner) {
        var index = ["x", "o"].indexOf(winner);
        alert("The winner is " + View.COLORS[index]);
      } else {
        alert("No winner!");
      }
      this.resetGame();
    }
  };
  
  View.prototype.resetGame = function() {
    $(".cell").off('click'); // remove events
    this.$el.empty(); // delete board
    this.game = new TTT.Game; // make a new game
    this.game.swapTurn(); // swap player
    this.setupBoard();
    this.bindEvents();
    this.colorIndex = 1; // swap player
  }
  

  View.prototype.setupBoard = function () {
    var string = "";
    for(var row = 0; row < 3; row++){
      for(var col = 0; col < 3; col++){
        string += "<div class='cell'" 
        string += "data-row='" 
        string += row +  "' data-col='"
        string += col + "'></div>";
      }
    }
    this.$el.append(string);
  };
})();
