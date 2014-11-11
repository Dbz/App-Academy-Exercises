(function() {
  if(typeof ASTEROIDS === "undefined") {
    window.ASTEROIDS = {};
  }
  
  var Bullet = ASTEROIDS.Bullet = function (ship) {
    var dir = ship.direction();
    var color = '#07E887';
    this.velX = dir[0] * Bullet.SPEED;
    this.velY = dir[1] * Bullet.SPEED;
    window.ASTEROIDS.MovingObject.apply(this, [ship.pos, [this.velX, this.velY], 1, color] );
  }
  
  Bullet.inherits(window.ASTEROIDS.MovingObject);
  
  Bullet.SPEED = 30;
  
})();
    
    