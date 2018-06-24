event_inherited();
subType = HandItemTypes.Shield;

#macro METAL "Metal"
#macro WOOD "Wood"

material = METAL;
// defenses -- different % for each element
defenses = ds_map_create();
for (var i = 0; i < array_length_1d(global.ALL_DAMAGE_TYPES); i++) {
	ds_map_replace(defenses, global.ALL_DAMAGE_TYPES[i],0);
}

handSpriteString = "spr_player_hand_shield";