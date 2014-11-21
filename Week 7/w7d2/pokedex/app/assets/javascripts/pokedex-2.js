Pokedex.RootView.prototype.addToyToList = function (toy) {
  var templateCode = $('#toy-list-item-template').html();
  var templateFn = _.template(templateCode);
  var content = templateFn({ toy: toy});
  $('ul.toys').append(content);
};

Pokedex.RootView.prototype.renderToyDetail = function (toy) { // III
  this.$toyDetail.empty();
  var templateCode = $('#toy-detail-template').html();
  var templateFn = _.template(templateCode);
  var content = templateFn({ toy: toy, pokes: this.pokes });
  this.$toyDetail.append(content);
};

Pokedex.RootView.prototype.selectToyFromList = function (event) {
  var $target = $(event.target);

  var toyId = $target.data('id');
  var pokemonId = $target.data('pokemon-id');

  var pokemon = this.pokes.get(pokemonId);
  var toy = pokemon.toys().get(toyId);

  this.renderToyDetail(toy);
};
