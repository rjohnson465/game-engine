with obj_attack {
	if place_meeting_layer(x,y,other.id) {
		with other {
			calculateDamage();
		}
	}
}

/*var doAttacksExist = instance_nearest(x,y,obj_attack) != noone;

if doAttacksExist {
	if place_meeting_layer(x,y,obj_attack) {
		// for each obj_attack touching us...
		//var attacksInside = scr_get_ids_region(obj_attack,bbox_left,bbox_top,bbox_right,bbox_bottom);
		
		var attacksInside = ds_list_create();
		
		with obj_attack {
			var x1 = other.bbox_left;
			var y1 = other.bbox_top;
			var x2 = other.bbox_right;
			var y2 = other.bbox_bottom;
			//if point_in_rectangle(x,y,other.bbox_left,other.bbox_top,other.bbox_right,other.bbox_bottom) {
			if rectangle_in_rectangle(x1,y1,x2,y2,bbox_left,bbox_top,bbox_right,bbox_bottom) {
				ds_list_add(attacksInside,id);
			}
		}
		
		show_debug_message(ds_list_size(attacksInside));
		
		for (var i = 0; i < ds_list_size(attacksInside); i++) {
			var attack =  ds_list_find_value(attacksInside,i);
			if attack.layer != layer exit;
			calculateDamage(attack);
		}
	}
}

// collision event code, old

/*
if other.layer != layer exit;
calculateDamage();
*/

