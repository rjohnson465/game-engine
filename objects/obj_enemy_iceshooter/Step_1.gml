/// @description Insert description here
// You can write your code in this editor

// always decide drops on death
if hp < 1 && isAlive && !isDying {
	// items
	
	//ds_map_destroy(tmap);
}

// Inherit the parent event
event_inherited();

// always be bursting particles
if hp > 1 {
	if layer >= global.player.layer {
		var x1 = bbox_left; var x2 = bbox_right;
		var y1 = bbox_top; var y2 = bbox_bottom;
		part_emitter_region(sporeSystem,sporeEmitter,x1,x2,y1,y2,ps_shape_ellipse,ps_distr_gaussian);
		part_emitter_burst(sporeSystem,sporeEmitter,sporeParticle, 2);
	}
}

if isMinion {
	hp -= .1;
}

// touching player hurts them
if alarm[4] <= 0 {
	if distance_to_object(obj_player) < 3 {
		with obj_player {
			var damagesMap = ds_map_create();
			ds_map_replace(damagesMap,ICE,[2,2]);
			ds_map_replace(damagesMap,PIERCE,[3,3]);
			damageCombatant(damagesMap,2,other.facingDirection,snd_hit1,other);
			ds_map_destroy(damagesMap); damagesMap = -1;
			other.alarm[4] = other.refreshCombatantsHit;
		}
	}
}