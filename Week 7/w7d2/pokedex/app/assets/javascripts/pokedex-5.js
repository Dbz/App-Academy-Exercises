Pokedex.Views = {}

Pokedex.Views.PokemonIndex = Backbone.View.extend({
  events: {
    'click li' : 'selectPokemonFromList'
  },

  initialize: function () {
    this.collection = new Pokedex.Collections.Pokemon();
  },

  addPokemonToList: function (pokemon) {
    var templateCode = $('#pokemon-list-item-template').html();
    var templateFn = _.template(templateCode);
    var content = templateFn({pokemon: pokemon});
    this.$el.append(content);
  },

  refreshPokemon: function (callback) {
    var that = this;
    this.collection.fetch({
      success: function() {
        that.render();
        if (callback) {
          callback();
        }
      }
    });
  },

  render: function () {
    var that = this;
    this.$el.empty();
    this.collection.forEach(function(pokemon) {
      that.addPokemonToList(pokemon);
    });
  },

  selectPokemonFromList: function (event) {
    var newPoke = new Pokedex.Models.Pokemon ({ id: $(event.target).data('id') });
    newPoke.fetch({
      success: function() { 
        Backbone.history.navigate("pokemon/" + newPoke.get('id'), {trigger: true});
      }
    });
  }
});

Pokedex.Views.PokemonDetail = Backbone.View.extend({
  events: {
    'click li' : 'selectToyFromList'
  },

  refreshPokemon: function (callback) {
    var that = this;
    this.model.fetch({ 
      success: function() { 
        that.render();
        if(callback)
          callback();
      }
    });
  },

  render: function () {
    var content = JST["pokemonDetail"]({ pokemon: this.model });
    this.$el.html(content);
    
    this.model.toys().forEach(function(toy) {
      var content = JST["toyListItem"]({ toy: toy });
      $('ul.toys').append(content);
    })
  },

  selectToyFromList: function (event) {
    var toy = this.model.toys().get($(event.target).data('id'));
    Backbone.history.navigate("pokemon/" + toy.get('pokemon_id') + "/toy/" + toy.get('id'), {trigger: true});
  }
});

Pokedex.Views.ToyDetail = Backbone.View.extend({
  render: function () {
    var that = this;
    var pokemon = new Pokedex.Collections.Pokemon();
    pokemon.fetch({
      success: function() {
        var content = JST["toyDetail"]({ pokes: pokemon, toy: that.model });
        that.$el.html(content);
      }
    });
  }
});

