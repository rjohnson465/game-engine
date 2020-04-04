/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

message = "Escort Herbie back to Mrs. Claus";

DESC_ESCORT = "Escort Herbie back to Mrs. Claus";
DESC_FIGHT = "Kill all nearby enemies to continue";
DESC_LONELY = "Walk closer to Herbie, he is nervous.";

herbie = instance_nearest(x, y, obj_npc_herbie);

idleFrame = 0;

pathObjectivesKeys = [
	"herbie_pp1",
	// "frozen_tree1",
	// "herbie_pp2",
	// "herbie_pp3",
	// "frozen_tree2",
	"mrsclaus"
];
pathObjectiveIndex = -1;
pathObjects = ds_list_create();
for (var i = 0; i < array_length_1d(pathObjectivesKeys); i++) {
	var poKey = pathObjectivesKeys[i];
	with all {
		if variable_instance_exists(id, "eventKey") && eventKey == poKey {
			ds_list_add(other.pathObjects, id);
		}
	}
}

justReachedPathObjective = false;