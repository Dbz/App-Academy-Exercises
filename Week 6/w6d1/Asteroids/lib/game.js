(function() {
  if(typeof ASTEROIDS === "undefined") {
    window.ASTEROIDS = {};
  }
  
  var Game = ASTEROIDS.Game = function () {
    this.asteroids = [];
    this.ship = new window.ASTEROIDS.Ship ();
    this.lives = 5;
    this.bullets = [];
  }
    
  Game.prototype.addAsteroids = function () {
    var num = Game.NUM_ASTEROIDS;
    while(num--) {
      var a = new window.ASTEROIDS.Asteroid(
        [Math.random() * Game.DIM_X, Math.random() * Game.DIM_Y],
        10    // radius
      );
      this.asteroids.push(a)
    }
  }
  
  Game.prototype.objects = function() {
    return this.asteroids.concat(this.bullets).concat(this.ship);
  }
  
  Game.prototype.draw = function(ctx) {
    ctx.clearRect(0, 0, Game.DIM_X, Game.DIM_Y);
    this.objects().forEach(function(obj) {
      obj.draw(ctx);
    })
    
    this.ship.draw(ctx);
  }
  
  Game.prototype.moveObjects = function () {
    this.objects().forEach(function(asteroid) {
      asteroid.move();
    });
  }
  
  Game.prototype.checkCollisions = function() {
    // for(var i = 0; i < this.asteroids.length; i++) {
    //   var current = this.asteroids[i];
    //   for(var j = 0; j < this.asteroids.length; j++) {
    //     if(current === this.asteroids[j]) {
    //       break;
    //     } else if(current.isCollidedWith(this.asteroids[j])) {
    //       this.remove(current);
    //       this.remove(this.asteroids[j]);
    //     }
    //   }
    // }
    for(var i = 0; i < this.asteroids.length; i++) {
      if(this.ship.isCollidedWith(this.asteroids[i])) {
        this.remove(this.asteroids[i]);
        this.remove(this.ship);
      }
    }
  }
  
  Game.prototype.step = function () {
    this.moveObjects();
    this.checkCollisions();
  }
  
  Game.prototype.remove = function (asteroid) {
    this.asteroids.splice(this.asteroids.indexOf(asteroid), 1);
    this.lives -= 1
    // if(this.lives) {
    //   this.ship = new window.ASTEROIDS.Ship ();
    // } else {
    //   console.log("Game over!");
    // }
    
  }
  
  
    
  Game.DIM_X = 800;
  Game.DIM_Y = 800;
  Game.NUM_ASTEROIDS = 10;
  
})();