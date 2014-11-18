Pokedex.RootView.prototype.renderPokemonDetail = function (pokemon) {
  $div = $('<div class="detail">');
  var $img = $('<img>');
  $img.attr('src', pokemon.attributes.image_url);
  $div.append($img);
  
  var $text  = $('<p>');
  var details = "";
  details += "Attack: " + pokemon.attributes.attack;
  details += "<br>";
  details += "Defense: " + pokemon.attributes.defense;
  details += "<br>";
  details += "Moves: " + pokemon.attributes.moves.join(", ");
  $text.html(details);
  
  $div.append($text);
  
  var $ul = $('<ul class="toys">');
  pokemon.fetch({
    success: function(){
      pokemon.toys().forEach(function(toy){
        this.addToyToList(toy, $ul);
      }.bind(this))
    }.bind(this)
  });
  
  $div.append($ul);
  this.$pokeDetail.html($div);

};

Pokedex.RootView.prototype.selectPokemonFromList = function (event) {
  var e = $(event.currentTarget);
  var pokemon = new Pokedex.Models.Pokemon({
    id: e.attr('id')
  });
  pokemon.fetch({
    success: function(data){
      this.renderPokemonDetail(pokemon);
    }.bind(this)
  })
};
