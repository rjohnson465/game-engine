event_inherited();
type = HandItemTypes.Shield;
// defenses -- different % for each element
defenses = ds_map_create();
for (var i = 0; i < array_length_1d(global.ALL_DAMAGE_TYPES); i++) {
	ds_map_replace(defenses, global.ALL_DAMAGE_TYPES[i],0);
}
blockPercentage = 50;