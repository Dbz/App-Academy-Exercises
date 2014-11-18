Pokedex.RootView.prototype.addToyToList = function (toy, $ul) {
  var $li = $('<li class="toy-list-item" data-toy-id="' + toy.id + '" data-pokemon-id="' + toy.attributes.pokemon_id + '">');
  var toyDetails = "";
  toyDetails += "Name: " + toy.attributes.name;
  toyDetails += "<br>";
  toyDetails += "Price: " + toy.attributes.price;
  toyDetails += "<br>";
  toyDetails += "Happiness: " + toy.attributes.happiness;
  var $p = $('<p>').html(toyDetails);
  $li.append($p);
  $ul.append($li);
};

Pokedex.RootView.prototype.renderToyDetail = function (toy) { // III
  var $div = $('<div class="detail">');
  var $toyImg = $("<img>");
  $toyImg.attr('src', toy.attributes.image_url);
  $div.append($toyImg)
  var toyDetails = "";
  toyDetails += "Name: " + toy.attributes.name;
  toyDetails += "<br>";
  toyDetails += "Price: " + toy.attributes.price;
  toyDetails += "<br>";
  toyDetails += "Happiness: " + toy.attributes.happiness;
  var $p = $('<p>').html(toyDetails);
  $div.append($p);
  this.$toyDetail.html($div);
};

Pokedex.RootView.prototype.selectToyFromList = function (event) {
  var $e = $(event.currentTarget);
  var pokemon = new Pokedex.Models.Pokemon({ id: $e.data('pokemon-id') });
  var that = this;
  pokemon.fetch({
    success: function() {
      var toy;
      pokemon.toys().forEach(function(t) {
        if(t.id == $e.data('toy-id'))
          toy = t;
      })
      that.renderToyDetail(toy);
    }
  });
  
};
