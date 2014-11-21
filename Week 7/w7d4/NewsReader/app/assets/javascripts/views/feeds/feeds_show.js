NewsReader.Views.FeedsShow = Backbone.View.extend({
	
	initialize: function(options) {
		this.listenTo(this.model, 'sync', this.render);
	},
	
	template: JST['feeds/show'],
	
	render: function() {
		var templateCode = this.template({feed: this.model});
		this.$el.html(templateCode);
		return this;
	}

});
