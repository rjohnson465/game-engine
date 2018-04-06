/// makeGold(min,max)
/// @param min minGold
/// @param max maxGold

var minGold = argument[0];
var maxGold = argument[1];

randomize();
var rand = round(random_range(minGold,maxGold));
if rand == 0 return noone;

var gold = instance_create_depth(x,y,1,obj_item_coins);
gold.count = rand;

return gold;