NewsReader.Collections.Feeds = Backbone.Collection.extend({
	url: '/api/feeds',
  model: NewsReader.Models.Feed,
	getOrFetch: function(id) {
		var feed = this.get(id);
		if(!feed) {
			var newFeed = new NewsReader.Models.Feed({id: id});
			newFeed.fetch();
			this.add(newFeed);
			return newFeed;
		} else {
			feed.fetch();
			return feed;
		}
	}
});