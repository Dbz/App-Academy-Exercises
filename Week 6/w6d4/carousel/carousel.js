$.Carousel = function (el) {
  this.$el = $(el);
  this.activeIdx = 0;
  this.$active = $(this.$el.find('.items img')[0]);
  this.$active.addClass('active');
  this.transitioning = false;
  $('.slide-left').on('click', this.slideLeft.bind(this));
  $('.slide-right').on('click', this.slideRight.bind(this));
  
};

$.Carousel.prototype.slideLeft = function(event) {
  this.slide(-1);
};

$.Carousel.prototype.slideRight = function(event) {
  this.slide(1);
};

$.Carousel.prototype.slide = function(dir) {
  if(this.transitioning)
    return;
  this.transitioning = true;
  var moveDir = "";
  moveDir = (~dir) ? 'right' : 'left';
  var oppDir = "";
  oppDir = (~dir) ? 'left' : 'right';
  
  this.activeIdx += dir;
  var len = this.$el.find('.items img').length;
  if(this.activeIdx < 0) {
    this.activeIdx = len - 1;
  } else if(this.activeIdx == len) {
    this.activeIdx = 0;
  }
  
  var $oldActive = this.$active;
  $oldActive.addClass(oppDir)
  this.$active = $(this.$el.find('.items img')[this.activeIdx]);
  this.$active.addClass(moveDir + ' active');
  
  setTimeout(function () {
    requestAnimationFrame(function() {
      this.$active.removeClass(moveDir);
    }.bind(this));
  }.bind(this), 0)
  
  this.$active.one('transitionend', function() {
    $oldActive.removeClass('active ' + oppDir);
    this.transitioning = false;
  }.bind(this));
};

$.fn.carousels = function () {
  return this.each(function () {
    new $.Carousel(this);
  });
};