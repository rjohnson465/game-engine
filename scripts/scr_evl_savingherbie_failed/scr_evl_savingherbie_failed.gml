/// scr_evl_savingherbie_failed(arr)
/// @param arr
var arr = argument[0];

var ev = arr[0];

if ev.object_index == obj_event_saving_herbie {
	// change current quest description
	description = "Herbie fled. Find him back at the wolf den to try again.";
	
	var mc = instance_nearest(x, y, obj_npc_mrsclaus);
	if instance_exists(mc) {
		mc.isInteractable = true;
	}
	
	var herbie = instance_nearest(x, y, obj_npc_herbie);
	if instance_exists(herbie) {
		herbie.isSolid = true;
	}
	
	with obj_npc_herbie {
		//isInteractingWithPlayer = false;
		//global.isInteractingWithNpc = false;
		x = wolfDenPostX;
		y = wolfDenPostY;
		path_end();
		speed = 0;
		alarm[1] = 1;
	}
}