(function () {
  if (typeof Hanoi === "undefined") {
    window.Hanoi = {};
  }
  
  var View = Hanoi.View = function($el) {
    this.$el = $el;
    this.game = new window.Hanoi.Game;
    this.setupTowers();
    this.bindEvents();
    this.startingTower = -1;
    this.towers = [[3, 2, 1], [], []]
  }
  
  View.prototype.setupTowers = function() {
    var str = "<div class='tower' data-tower='0'>"
    str += "<div class='disc' id='c'></div>";
    str += "<div class='disc' id='b'></div>";
    str += "<div class='disc' id='a'></div>";
    str += "</div>";
    str += "<div class='tower' data-tower='1'></div>";
    str += "<div class='tower' data-tower='2'></div>";
    
    this.$el.append(str);
  }
  
  View.prototype.bindEvents = function() {
    $('.tower').on('click', this.moveDisc.bind(this));
  }
  
  View.prototype.moveDisc = function(event) {
    var tower = $(event.currentTarget);
    var num = tower.data('tower');
    
    if(~this.startingTower) {
      if (!this.game.isValidMove(this.startingTower, num)) {
        this.startingTower = -1;
        return;
      } 
      
      // Move disc in memory
      var disc = this.towers[this.startingTower].pop(); 
      this.towers[num].push(disc);
      
      // Move disc on page
      var startingTower = $('[data-tower="' + this.startingTower + '"]');
      startingTower.find(">:last-child").detach().appendTo(tower);
      
      // Move disc in game-core
      this.game.move(this.startingTower, num);
      
      // Move completed
      this.startingTower = -1;
      if (this.game.isWon()) {
        alert("You Won!!!!!!!!!!!!!!!!!");
      }
      
    } else {
      this.startingTower = num;
      if(this.towers[this.startingTower].length == 0) {
        this.startingTower = -1;
        return;
      }
    }
    
    
    
  }
})();
  
  