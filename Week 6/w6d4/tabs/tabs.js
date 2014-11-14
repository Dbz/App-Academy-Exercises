$.Tabs = function (el) {
  this.$el = $(el);
  
  this.$contentTabs = $(this.$el.data('content-tabs')); // #=> '#content-tabs'
  this.$activeTab = this.$contentTabs.find('.active');
  this.$el.on('click', 'a', this.clickTab.bind(this));
};

$.Tabs.prototype.clickTab = function(event) {
  event.preventDefault();
  
  this.$el.find('.active').removeClass('active');
  $(event.currentTarget).addClass('active');
  
  var that = this;
  var linkClicked = $(event.currentTarget);
  this.$activeTab.addClass('transitioning');
  this.$activeTab.one('transitionend', function(event) {
    $(event.currentTarget).removeClass('transitioning');
    that.$activeTab.removeClass('active');
    that.$activeTab = that.$contentTabs.find(linkClicked.attr('href'));
    that.$activeTab.addClass('active transitioning');
    // that.$activeTab.addClass('transitioning');
    setTimeout(function() {
      that.$activeTab.removeClass('transitioning');
    }, 0);
  });
};

$.fn.tabs = function () {
  return this.each(function () {
    new $.Tabs(this);
  });
};
