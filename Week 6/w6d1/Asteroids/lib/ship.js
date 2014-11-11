(function() {
  if(typeof ASTEROIDS === "undefined") {
    window.ASTEROIDS = {};
  }
  
  var Ship = ASTEROIDS.Ship = function () {
    this.velX = 0;
    this.velY = 0;
    var game = window.ASTEROIDS.Game;
    var pos = [game.DIM_X / 2, game.DIM_Y / 2];
    this.pos = pos;
    var color = "#D12173";
    window.ASTEROIDS.MovingObject.apply(this, [pos, [0, 0], 10, color] );
  }
  Ship.inherits(window.ASTEROIDS.MovingObject);
  
  Ship.prototype.power = function(impulse) {
    this.velX += impulse[0];
    this.velY += impulse[1];
  }
  
  Ship.prototype.rotate = function(dir) {
    //
  }
  
  Ship.prototype.fireBullet = function() {
    var bullet = new window.ASTEROIDS.Bullet();
    window.ASTEROIDS.Game.bullets.push(bullet);
  }
  
  
  
})();