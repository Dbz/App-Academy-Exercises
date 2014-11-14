$.Thumbnail = function(el){
  this.$el = $(el);
  this.$active = this.$el.find('.active');
  this.$saveImage = $(this.$el.find('.gutter-images img')[0]);
  this.activate(this.$saveImage, false);
  
  this.$images = $(this.$el.find('.gutter-images')).clone();
  this.gutterIdx = 17;
  this.fillGutterImages();

  this.$el.find('.gutter-images').on('click', 'img', function(event) {
    this.activate($(event.currentTarget), true);
  }.bind(this));
  
  this.$el.find('.gutter-images').on('mouseenter', 'img', function(event){
    this.activate($(event.currentTarget), false);
  }.bind(this));
  
  this.$el.find('.gutter-images').on('mouseleave', function(){
    this.activate(this.$saveImage, false);
  }.bind(this));
  
  this.$el.find('.nav').on('click', function(event) {
    event.currentTarget.id == 'left' ? this.gutterIdx -= 1 : this.gutterIdx += 1;
    if(this.gutterIdx == 20)
      this.gutterIdx = 0;
    if(this.gutterIdx == -1)
      this.gutterIdx = 19;
    this.fillGutterImages();
  }.bind(this));
};

$.Thumbnail.prototype.activate = function($img, saveImageBool) {
  this.$active.empty();
  this.$active.append($img.clone());
  if(saveImageBool)
    this.$saveImage = $img;
};

$.Thumbnail.prototype.fillGutterImages = function() {
  var $gutter = $('.gutter-images');
  $gutter.empty();
  var images = this.$images.clone().children();
  if(this.gutterIdx + 5 <= images.length - 1) {
    for(var i = this.gutterIdx; i < this.gutterIdx + 5; i++)
      $gutter.append(images[i])
  }
  else {
    for(var i = this.gutterIdx; i < images.length; i++)
      $gutter.append(images[i]);
    for(var i = 0; i < (this.gutterIdx + 5 - images.length); i++)
      $gutter.append(images[i]);
  }
}

$.fn.thumbnails = function () {
  return this.each(function () {
    new $.Thumbnail(this);
  });
};