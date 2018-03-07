/*var doAttacksExist = instance_nearest(x,y,obj_attack) != noone;

if doAttacksExist {
	if place_meeting_layer(x,y,obj_attack) {
		// for each obj_attack touching us...
		var attacksInside = scr_get_ids_region(obj_attack,bbox_left,bbox_top,bbox_right,bbox_bottom);
	
		for (var i = 0; i < ds_list_size(attacksInside); i++) {
			var attack =  ds_list_find_value(attacksInside,i);
			if attack.layer != layer exit;
			calculateDamage(attack);
		}
	}
}