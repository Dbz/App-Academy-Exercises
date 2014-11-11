(function() {
  if(typeof ASTEROIDS === "undefined") {
    window.ASTEROIDS = {};
  }
  
  
  
  var MovingObject = ASTEROIDS.MovingObject = function (pos, vel, radius, color) {
    this.pos = pos;
    this.velX = vel[0];
    this.velY = vel[1];
    this.radius = radius;
    this.color = color;
  }
  
  MovingObject.prototype.direction = function () {
    var magnitude = Math.sqrt(Math.pow(this.velX, 2) + Math.pow(this.velY, 2));
    return [this.velX / magnitude, this.velY / magnitude];
  }

  MovingObject.prototype.draw = function (ctx) {
    ctx.beginPath();
    ctx.fillStyle = this.color;
    this.updatePos();
    ctx.arc(this.pos[0], this.pos[1], this.radius, 0, 2 * Math.PI);
    //ctx.closePath();
    ctx.fill();
  }

  MovingObject.prototype.move = function () {
    this.pos[0] += this.velX;
    this.pos[1] += this.velY;
    
    // this.updatePos();
  }
  
  MovingObject.prototype.updatePos = function() {
    var x = this.pos[0];
    var y = this.pos[1];
    var Game = window.ASTEROIDS.Game;
    
    if(x > Game.DIM_X) {
      x -= Game.DIM_X;
    } else if(x < 0) {
      x += Game.DIM_X;
    }
    
    if(y > Game.DIM_Y) {
      y -= Game.DIM_Y;
    } else if(y < 0) {
      y += Game.DIM_Y;
    }
    
    this.pos = [x, y]
  }
  
  MovingObject.prototype.isCollidedWith = function (otherObject) {
    var dist = Math.sqrt(
      Math.pow(this.pos[0] - otherObject.pos[0], 2) +
      Math.pow(this.pos[1] - otherObject.pos[1], 2)
    );
    return (dist < this.radius + otherObject.radius);
  }
  
})();
