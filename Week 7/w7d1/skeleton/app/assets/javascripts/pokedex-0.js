window.Pokedex = (window.Pokedex || {});
window.Pokedex.Models = {};
window.Pokedex.Collections = {};

Pokedex.Models.Pokemon = Backbone.Model.extend({
  urlRoot: '/pokemon',
  
  toys: function () {
    this._toys = this._toys || new Pokedex.Collections.PokemonToys();
    return this._toys
  },
  
  parse: function (payload) {
    if(payload.toys) {
      this.toys().set(payload.toys);
      delete payload.toys;
    }
    return payload;
  }
});

Pokedex.Models.Toy = Backbone.Model.extend({ // WRITE ME IN PHASE 2
  
});

Pokedex.Collections.Pokemon = Backbone.Collection.extend({
  model: Pokedex.Models.Pokemon,
  url: '/pokemon'
});

Pokedex.Collections.PokemonToys = Backbone.Collection.extend({ // WRITE ME IN PHASE 2
  model: Pokedex.Models.Toy,
  url: function() {
    return '/pokemon/' + this.pokemon.id
  }.bind(this)
}); 

window.Pokedex.Test = {
  testShow: function (id) {
    var pokemon = new Pokedex.Models.Pokemon({ id: id });
    pokemon.fetch({
      success: function () {
        console.log(pokemon.toJSON());
      }
    });
  },

  testIndex: function () {
    var pokemon = new Pokedex.Collections.Pokemon();
    pokemon.fetch({
      success: function () {
        console.log(pokemon.toJSON());
      }
    });
  }
};

window.Pokedex.RootView = function ($el) {
  this.$el = $el;
  this.pokes = new Pokedex.Collections.Pokemon();
  this.$pokeList = this.$el.find('.pokemon-list');
  this.$pokeDetail = this.$el.find('.pokemon-detail');
  this.$newPoke = this.$el.find('.new-pokemon');
  this.$toyDetail = this.$el.find('.toy-detail');
  

  // Click handlers go here.
  this.$pokeList.on("click", "li", this.selectPokemonFromList.bind(this));
  $('form.new-pokemon').on('submit', this.submitPokemonForm.bind(this));
  $('.pokemon-detail').on('click', 'li', this.selectToyFromList.bind(this));
};

$(function() {
  var $rootEl = $('#pokedex');
	window.Pokedex.rootView = new Pokedex.RootView($rootEl);
  window.Pokedex.rootView.refreshPokemon();
});
