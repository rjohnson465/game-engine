depth = 100;
owner = global.owner; // the enemy instance who is dead
potentialItems = owner.dropItems;
sprite_index = asset_get_index("spr_"+owner.spriteString+"_dead");

// actually decide items here
items = ds_list_create();

var currentKey = ds_map_find_first(potentialItems);
for (var i = 0; i < ds_map_size(potentialItems); i++) {
	var probability = ds_map_find_value(potentialItems,currentKey);
	
	randomize();
	var rand = random_range(0,100);
	if rand < probability {
		ds_list_add(items,currentKey);
	}
	currentKey = ds_map_find_next(potentialItems,currentKey);
}