
var ring = instance_create_depth(x,y,1,obj_item_ring);
addItemProperty(ring, ModifiableProperties.PoiseMax, 10);
addItemProperty(ring, ModifiableProperties.Defenses,[PIERCE, 7]);
addItemProperty(ring, ModifiableProperties.ElementalDamageTypesMultiplier,[MAGIC, 100]);
addItemProperty(ring, ModifiableProperties.StaminaSteal,10);

addItemToInventory(ring);


//xpTemp += 500;

/*
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