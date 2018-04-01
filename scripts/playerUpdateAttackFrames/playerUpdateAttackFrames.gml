if ds_map_size(attackingLimbs) != 0 {
	var hand = ds_map_find_first(attackingLimbs);
	for (var i = 0; i < ds_map_size(attackingLimbs); i++) {
		var idd = id;
		var attackObj = noone;
		with obj_attack {
			if owner = idd && limbKey == hand {
				attackObj = id;
			}
		}
		if attackObj != noone {
			var a = attackObj.image_index;
			ds_map_replace(attackFrames,hand,attackObj.image_index);
		}
		hand = ds_map_find_next(attackingLimbs, hand);
	}
}