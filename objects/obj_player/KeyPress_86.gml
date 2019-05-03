var pmap = ds_map_create();
ds_map_add(pmap, obj_item_antidote, 5);
ds_map_add(pmap, obj_item_rubberducky, 5);
ds_map_add(pmap, obj_item_icecube, 5);
ds_map_add(pmap, obj_item_jalapeno, 5);
ds_map_add(pmap, obj_item_blessing, 5);
ds_map_add(pmap, obj_item_spearmint_elixir, 3);
ds_map_add(pmap, obj_item_club_soda, 3);
ds_map_add(pmap, obj_item_razorade, 3);
var item3 = maybeMakeItemBasic(pmap);

addItemToInventory(item3);
	
ds_map_destroy(pmap); pmap = -1;