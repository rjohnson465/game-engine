/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

message = "Escort Herbie to Mrs. Claus";

DESC_ESCORT = "Escort Herbie to Mrs. Claus";
DESC_FIGHT = "Kill nearby enemies";
DESC_LONELY = "Stay closer to Herbie";

herbie = instance_nearest(x, y, obj_npc_herbie);

idleFrame = 0;

//pathObjectivesKeys = [
//	"t1",
//	"p1",
//	"p2",
//	"p3",
//	"t2",
//	"p4",
//	"p5",
//	"p6",
//	"t2.5",
//	"t3",
//	"p7",
//	"t4",
//	"p8",
//	"t5",
//	"mrsclaus"
//];

pathObjectiveIndex = -1;
pathObjects = ds_list_create();
if instance_exists(herbie) {
	for (var i = 0; i < array_length_1d(herbie.pathObjectivesKeys); i++) {
		var poKey = herbie.pathObjectivesKeys[i];
		with all {
			if variable_instance_exists(id, "eventKey") && eventKey == poKey {
				ds_list_add(other.pathObjects, id);
			}
		}
	}
}

justReachedPathObjective = false;