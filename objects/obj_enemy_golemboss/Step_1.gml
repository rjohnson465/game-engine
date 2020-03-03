/// @description Insert description here
// You can write your code in this editor

// always decide drops on death
if hp < 1 && isAlive && !isDying {
	
	// spawn dybukkboss
	var dybukkboss = instance_create_layer(x,y,global.player.layer,obj_enemy_dybukkboss);
	dybukkboss.isBossKilledBefore = isBossKilledBefore;
	
	var lr = noone;
	with obj_light_radius {
		if owner == other.id {
			lr = id;
		}
	}
	if lr != noone {
		with lr {
			event_perform(ev_other, ev_room_start);
		}
	}
	
}



// Inherit the parent event
event_inherited();