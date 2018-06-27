event_inherited();

type = ItemTypes.Head;
isStackable = false;

defenses = ds_map_create();
for (var i = 0; i < array_length_1d(global.ALL_DAMAGE_TYPES); i++) {
	ds_map_replace(defenses, global.ALL_DAMAGE_TYPES[i],0);
}

durability = 50;
durabilityMax = 50;

socketedGems = ds_list_create();

soundDrop = snd_item_cloth;