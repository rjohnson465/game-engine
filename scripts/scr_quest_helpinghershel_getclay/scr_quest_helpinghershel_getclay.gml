/// scr_quest_helpinghershel_getclay

// called when talking with ari again after failing to save hershel

// change queststep description and get clayheart again
addItemToInventory(instance_create_depth(x, y, 1, obj_item_clayheart), true);
var qs = instance_nearest(x, y, obj_queststep_helpinghershel_1);
qs.description = "Place the Clayheart within Hershel";

