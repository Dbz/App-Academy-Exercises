Pokedex.Router = Backbone.Router.extend({
  routes: {
    "": "pokemonIndex",
    "pokemon/:id": "pokemonDetail",
    "pokemon/:pokemonId/toy/:toyId": "toyDetail"
  },

  pokemonDetail: function (id, callback) {
    var that = this;
    if(!this._pokemonIndex) {
      this.pokemonIndex(function() {
        return that.pokemonDetail(id, callback);
      });
      return;
    }
    var pokemon = this._pokemonIndex.collection.get(id);
    var newView = new Pokedex.Views.PokemonDetail({ model: pokemon });
    $("#pokedex .pokemon-detail").html(newView.$el);
    newView.refreshPokemon(callback);
    this._pokemonDetail = newView;
  },

  pokemonIndex: function (callback) {
    var pokemonIndex = new Pokedex.Views.PokemonIndex();
    pokemonIndex.refreshPokemon(callback);
    $("#pokedex .pokemon-list").html(pokemonIndex.$el);
    this._pokemonIndex = pokemonIndex;
  },

  toyDetail: function (pokemonId, toyId) {
    var that = this;
    if(!this._pokemonDetail) {
      this.pokemonDetail(pokemonId, function() {
        return that.toyDetail(pokemonId, toyId);
      });
      return;
    }
    var toy = this._pokemonDetail.model.toys().get(toyId);

    var newView = new Pokedex.Views.ToyDetail({ model: toy});
    $("#pokedex .toy-detail").html(newView.$el);
    newView.render();
  }
});


$(function () {
  new Pokedex.Router();
  Backbone.history.start();
});

