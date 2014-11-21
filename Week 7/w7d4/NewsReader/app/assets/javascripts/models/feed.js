NewsReader.Models.Feed = Backbone.Model.extend({
	urlRoot: '/api/feeds',
	
	parse: function(payload) {
		if(payload.latest_entries) {
			this.entries().set(payload.latest_entries, {parse: true});
			delete payload.latest_entries;
		}
		
		return payload;
	},
	
	entries: function() {
		if (this._entries) {
			return this._entries;
		} else {
		  this._entries = new NewsReader.Collections.Entries([], { feed: this});
			return this._entries;
		}
	}
	
});
