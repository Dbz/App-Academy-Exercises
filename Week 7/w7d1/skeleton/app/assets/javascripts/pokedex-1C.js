Pokedex.RootView.prototype.createPokemon = function (attrs, callback) {
  var pokemon = new Pokedex.Models.Pokemon(attrs);
  pokemon.save([], {
    success: function(){
      this.pokes.push(pokemon);
      this.addPokemonToList(pokemon);
      callback.call(this, pokemon);
    }.bind(this)
  })

};

Pokedex.RootView.prototype.submitPokemonForm = function (event) {
  event.preventDefault();
  $e = $(event.currentTarget);
  this.createPokemon($e.serializeJSON()["pokemon"], this.renderPokemonDetail);
};
