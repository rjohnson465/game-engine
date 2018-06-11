if !instance_exists(npc) exit;
var currentC = ds_map_find_first(conversations);
for (var i = 0; i < ds_map_size(conversations); i++) {
	// find conversation object in npc obj by name
	var cObj = noone;
	with obj_conversation_parent {
		if owner = other.npc && name == currentC {
			cObj = id;
		}
	}
	if instance_exists(cObj) {
		cObj.isFinished = ds_map_find_value(conversations,currentC);
	}
			
	currentC = ds_map_find_next(conversations,currentC);
}
