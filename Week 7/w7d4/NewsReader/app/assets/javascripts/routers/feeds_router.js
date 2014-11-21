NewsReader.Routers.Feeds = Backbone.Router.extend({
  initialize: function (options) {
  	this.$rootEl = options.$rootEl;
  },
	
	routes: {
		"": "feedIndex",
		"feeds/:id": "feedShow"
	},
	
	feedIndex: function () {
		NewsReader.feeds.fetch();
		var indexView = new NewsReader.Views.FeedsIndex({
			collection: NewsReader.feeds
		});
		this._swapView(indexView);
	},
	
	feedShow: function (id) {
		var feed = NewsReader.feeds.getOrFetch(id);
		feed.fetch();
		var showView = new NewsReader.Views.FeedsShow({
			model: feed
		});
		this._swapView(showView);
		
		// that = this;
		// NewsReader.feeds.fetch({
		// 	success: function() {
		// 		var feed = NewsReader.feeds.get(id);
		// 		var showView = new NewsReader.Views.FeedsShow({
		// 			model: feed
		// 		});
		// 		that._swapView(showView);
		// 	}
		// })
	},
	
	_swapView: function (newView) {
		this._currentView && this._currentView.remove();
		this._currentView = newView;
		this.$rootEl.html(this._currentView.render().$el);
	}
});