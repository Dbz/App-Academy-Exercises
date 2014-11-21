Pokedex.RootView.prototype.renderPokemonDetail = function (pokemon) {
  var templateCode = $('#pokemon-detail-template').html();
  var templateFn = _.template(templateCode);
  var content = templateFn({ pokemon: pokemon });
   
  this.$pokeDetail.html(content);
  
  pokemon.fetch({
    success: (function() {
      this.renderToysList(pokemon.toys());
    }).bind(this)
  });
};

Pokedex.RootView.prototype.selectPokemonFromList = function (event) {
  
  // Phase II
  this.$toyDetail.empty();

  // Phase IB
  var $target = $(event.target);

  var pokeId = $target.data('id');
  var pokemon = this.pokes.get(pokeId);

  this.renderPokemonDetail(pokemon);
};
