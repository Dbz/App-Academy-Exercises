function Cat(name, owner) {
  this.name = name;
  this.owner = owner;
}

Cat.prototype.cuteStatement = function(){
  return ("Everyone loves " + this.name);
}

Cat.prototype.meow = function(){
  return ("meow");
}


aaron = new Cat("Aaron", "Jesus");
fatty = new Cat("Fatty", "Jesus");
console.log(aaron.cuteStatement());
console.log(fatty.cuteStatement());

fatty.meow = function(){
  return "FATMEOW";
}
console.log(aaron.meow());
console.log(fatty.meow());