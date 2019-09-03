/*var rmap = ds_map_create();
ds_map_replace(rmap,ItemRarities.Normal,0);
ds_map_replace(rmap,ItemRarities.Fine,0);
ds_map_replace(rmap,ItemRarities.Masterwork,5);
ds_map_replace(rmap,ItemRarities.Legendary,5);

var item1 = maybeMakeItem(100,rmap); //randomly generated item
addItemToInventory(item1);
*/
/*
maybeApplyElementalCondition(MAGIC, 500, noone, noone);
maybeApplyElementalCondition(MAGIC, 500, noone, noone);

/*
for (var i = 0; i < array_length_1d(global.ALL_DAMAGE_TYPES); i++) {
	var ele = global.ALL_DAMAGE_TYPES[i];
	if ele == PHYSICAL continue;
	randomize();
	var rand = random_range(5,500);
	maybeApplyElementalCondition(ele, rand, noone, noone);
}







/*
var key = makeKey("Great-Lodge F2 Key", "key", spr_item_key, "Opens the door to the Fairy's Great-Lodge, Level 2. We really should have more than one copy of this thing.");
addItemToInventory(key);



//xpTemp += 500;

/*

var ring = instance_create_depth(x,y,1,obj_item_ring);
addItemProperty(ring, ModifiableProperties.PoiseMax, 3);
addItemToInventory(ring);

var reward = instance_create_depth(x,y,1, obj_item_reward);
ds_list_add(reward.items, instance_create_depth(x,y,1,obj_hand_item_longsword));
ds_list_add(reward.items, instance_create_depth(x,y,1,obj_hand_item_hatchet));
ds_list_add(reward.items, instance_create_depth(x,y,1,obj_hand_item_spear));
ds_list_add(reward.items, instance_create_depth(x,y,1,obj_hand_item_dagger));
ds_list_add(reward.items, instance_create_depth(x,y,1,obj_hand_item_club));

ds_list_add(reward.items, instance_create_depth(x,y,1,obj_hand_item_foil));
ds_list_add(reward.items, instance_create_depth(x,y,1,obj_hand_item_warhammer));

/*
var rmap = ds_map_create();
ds_map_replace(rmap,ItemRarities.Normal,0);
ds_map_replace(rmap,ItemRarities.Fine,5);
ds_map_replace(rmap,ItemRarities.Masterwork,5);
ds_map_replace(rmap,ItemRarities.Legendary,5);

var item1 = maybeMakeItem(100,rmap); //randomly generated item
addItemToInventory(item1);

updateNarrativeState(NarrativeState.LamplightFactory);