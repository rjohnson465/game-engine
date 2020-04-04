/// makeGold(min,max*)
/// @param min minGold
/// @param max* maxGold optional

var minGold = argument[0];
var maxGold = minGold;
if argument_count > 1 {
	maxGold = argument[1];
}

// if this is gold being dropped from a monster, factor player item gold drop
if object_is_ancestor(object_index,obj_enemy_parent) {
	var goldDropMultiplier = global.player.goldDropMultiplier;
	minGold *= (goldDropMultiplier/100);
	maxGold *= (goldDropMultiplier/100);
}

randomize();
var rand = round(random_range(minGold,maxGold));
if rand == 0 return noone;

var gold = instance_create_depth(x,y,1,obj_item_coins);
gold.count = rand;

return gold;