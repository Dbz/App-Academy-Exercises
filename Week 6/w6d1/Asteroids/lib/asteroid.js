(function() {
  if(typeof ASTEROIDS === "undefined") {
    window.ASTEROIDS = {};
  }
  
  var Asteroid = ASTEROIDS.Asteroid = function (pos, radius) {
    var vel = [Math.random() * (10 + 10) - 10, Math.random() * (10 + 10) - 10];
    window.ASTEROIDS.MovingObject.apply(this, [pos, vel, radius, Asteroid.COLOR] );
  }
  
  Asteroid.COLOR = '#0F6875'
  
  Asteroid.inherits(window.ASTEROIDS.MovingObject);
})();