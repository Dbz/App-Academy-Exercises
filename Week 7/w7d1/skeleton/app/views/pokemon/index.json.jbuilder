json.array!(@pokemon) do |p|
  json.partial! 'pokemon', pokemon: p, display_toys: false
end