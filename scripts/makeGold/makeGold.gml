/// makeGold(min,max)
/// @param minGold
/// @param maxGold

// TODO return gold object
randomize();
var minimum = argument[0];
var maximum = argument[1];
var rand = round(random_range(minimum,maximum));
if rand < 1 {
	return noone;
} else return rand;
