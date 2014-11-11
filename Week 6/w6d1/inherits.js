Function.prototype.inherits = function (SuperClass) {
  function Surrogate() {};
  Surrogate.prototype = SuperClass.prototype;
  this.prototype = new Surrogate ();
}

function MovingObject () {};

MovingObject.prototype.speak = function () {
  console.log("hello");
}

function Ship () {};
Ship.inherits(MovingObject);

Ship.prototype.sink = function () {
  console.log("ship sinking");
}

function Asteroid () {};
Asteroid.inherits(MovingObject);

m = new MovingObject();
s = new Ship();
s.sink();
s.speak();
m.sink();