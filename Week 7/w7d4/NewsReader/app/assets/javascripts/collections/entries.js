NewsReader.Collections.Entries = Backbone.Collection.extend({

  model: NewsReader.Models.Entry,
	
	initialize: function(models, options) {
		this.feed = options.feed;
	}

});
