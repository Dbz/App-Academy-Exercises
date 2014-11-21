NewsReader.Views.FeedsIndex = Backbone.View.extend({
	
	initialize: function(options) {
		this.listenTo(this.collection, 'sync', this.render);
	},
	
	template: JST['feeds/index'],
	
	render: function() {
		var templateCode = this.template({feeds: this.collection});
		this.$el.html(templateCode);
		return this;
	}

});
