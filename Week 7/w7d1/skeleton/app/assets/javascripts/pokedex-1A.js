Pokedex.RootView.prototype.addPokemonToList = function (pokemon) {
  var $li = $("<li>");
  $li.attr("id", pokemon.attributes.id);
  $li.text(pokemon.attributes.name + ": " + pokemon.attributes.poke_type);
  $li.addClass("poke-list-item");
  
  this.$pokeList.append($li);
};

Pokedex.RootView.prototype.refreshPokemon = function (callback) {
  this.pokes.fetch({
    success: function(data) {
      data.forEach(function(pokemon) {
        this.addPokemonToList(pokemon);
      }.bind(this));
    }.bind(this)
  });
};
