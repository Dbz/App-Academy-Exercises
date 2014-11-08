//minutes = startTime.getMinutes;
Function.prototype.myBind = function (context) {
  var fn = this;
  return function() {
    fn.apply(context);
  }
}

function Clock () {
  this.startTime = new Date();
  this.hours = this.startTime.getHours();
  this.minutes = this.startTime.getMinutes();
  this.seconds = this.startTime.getSeconds();
}

Clock.TICK = 5000;

Clock.prototype.printTime = function () {
  // Format the time in HH:MM:SS
  console.log(this.hours, ":", this.minutes, ":", this.seconds);
};

Clock.prototype.run = function () {
  // 1. Set the currentTime.
  // 2. Call printTime.
  // 3. Schedule the tick interval.
  this.printTime();
  setInterval(
    this._tick.myBind(this), Clock.TICK);
};

Clock.prototype._tick = function () {
  this.seconds += 5;
  if(this.seconds > 60) {
    this.seconds -= 60;
    this.minutes += 1;
  }
  if(this.minutes > 60) {
    this.minutes -= 60;
    this.hours += 1;
  }
  if(this.hours > 24)
    this.hours -= 24;
  
  this.printTime();
};

clock = new Clock();
clock.run();
