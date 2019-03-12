/// isCurrentInteractionObject(obj)
/// @param obj

// returns whether or not this object is up to be interacted with
// this is only for non-explicitly prioritized interactable objects (i.e. doors, sconces)

var obj = argument[0];
var p = global.player;

var list = p.nonPriorityInteractionPrompts;

var firstKey = "";

if ds_list_size(list) > 0 {
	// make sure this object still exists 
	do {
		firstKey = ds_list_find_value(list,0);
		var foundObj = false;
		with obj_persistent_environment {
			if key == firstKey {
				foundObj = true;
			}
		}
		if !foundObj {
			with obj_tutorial_message {
				if key == firstKey {
					foundObj = true;
				}
			}
		}
		if !foundObj {
			ds_list_delete(list,0);
		}
	} until foundObj || ds_list_size(list) <= 0
}

return firstKey == obj.key;