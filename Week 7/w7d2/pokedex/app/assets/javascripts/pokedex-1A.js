Pokedex.RootView.prototype.addPokemonToList = function (pokemon) {
  var templateCode = $('#pokemon-list-item-template').html();
  var templateFn = _.template(templateCode);
  var content = templateFn({pokemon: pokemon});
  this.$pokeList.append(content);

};

Pokedex.RootView.prototype.refreshPokemon = function (callback) {
  this.pokes.fetch({
    success: (function () {
      this.$pokeList.empty();
      this.pokes.each(this.addPokemonToList.bind(this));
      callback && callback();
    }).bind(this)
  });

  return this.pokes;
};
