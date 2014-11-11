(function() {
  if(typeof ASTEROIDS === "undefined") {
    window.ASTEROIDS = {};
  }
  
  var GameView = ASTEROIDS.GameView = function (game, canvas) {
    this.game = game;
    this.ctx = canvas.getContext("2d");
  }
    
  GameView.prototype.start = function () {
    this.game.addAsteroids();
    this.bindKeyHandlers();
    
    setInterval((function () {
      this.game.step();
      this.game.draw(this.ctx);

    }).bind(this), 10);
  }
  
  window.ASTEROIDS.GameView.prototype.bindKeyHandlers = function() {
    var that = this;
    
    key('up', function() {
      console.log('hello');
      that.game.ship.power([1,1]);
    });
    
    key('down', function() {
      that.game.ship.power([-1,-1]);
    });
    
    key('right', function() {
      that.game.ship.rotate(1);
    });
    
    key('left', function() {
      that.game.ship.rotate(-1);
    })
    
    key('space', function() {
      that.game.ship.fireBullet();
    });
    
  }

})();