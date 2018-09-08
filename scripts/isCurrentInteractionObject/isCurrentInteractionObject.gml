/// isCurrentInteractionObject(obj)
/// @param obj

// returns whether or not this object is up to be interacted with
// this is only for non-explicitly prioritized interactable objects (i.e. doors, sconces)

var obj = argument[0];
var p = global.player;

var list = p.nonPriorityInteractionPrompts;
var firstKey = ds_list_find_value(list,0);
return firstKey == obj.key;