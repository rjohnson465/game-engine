if object_is_ancestor(other.object_index,obj_combatant_parent) {
	exit;
}

if object_is_ancestor(other.object_index, obj_npc_parent) && isRanged {
	instance_destroy(id); exit;
}

if (other.layer != layer && abs(abs(other.depth)-abs(depth)) > 5) {
	exit;
}

var x1 = x + lengthdir_x(100,owner.facingDirection);
var y1 = y + lengthdir_y(100,owner.facingDirection);

var firstObj = noone;
var possibleSolids = scr_collision_line_list_layer(x,y,x1,y1,obj_solid_parent,true,true);
if possibleSolids != noone {
	var closestDist = 1000;
	for (var i = 0; i < ds_list_size(possibleSolids); i++) {
		var el = ds_list_find_value(possibleSolids,i);
		if !object_is_ancestor(el.object_index,obj_combatant_parent) && distance_to_object(el) < closestDist {
			firstObj = el;
		}
	}
}
if possibleSolids != noone && ds_exists(possibleSolids, ds_type_list) {
	ds_list_destroy(possibleSolids); possibleSolids = -1;
}

var hitsWallFirst = firstObj == other.id;
if isMelee && hitsWallFirst && !object_is_ancestor(other.object_index,obj_npc_parent) {
	if owner.type == CombatantTypes.Player {
		if weapon.weaponType != UNARMED {
			damageItem(weapon,1);
		}
	}
	owner.staggerFrame = 0;
	owner.staggerDuration = 5;
	owner.staggerDirection = (owner.facingDirection+180)%360;
	path_end();
	// run to get __x and __y (collision point where attack meet this combatant)
	if script_execute(scr_collision_point,id,other.id) {
		global.damageType = other.material == METAL ? "Block" : "Dust";
		if owner.type == CombatantTypes.Player && weapon.weaponType == UNARMED {
			global.damageType = "Dust";
		}
		global.x1 = __x;
		global.y1 = __y;
		global.particleDirection = facingDirection;
		instance_create_depth(0,0,1,obj_hit_particles);
		if !isSpell {
			// play wall hit sound, dependent on type of material wall is
			var snd = global.damageType == "Dust" ? snd_shield_hit_wood : snd_wallhit;
			audio_play_sound_at(snd,__x,__y,depth,100,300,1,0,1);
		}
	}
	
	if owner.hasHands {
		var attackInChain = ds_map_find_value(owner.attackingLimbs,limbKey);
		ds_map_delete(owner.attackingLimbs,limbKey);
	}
	
	instance_destroy(id,true);
	owner.state = CombatantStates.Staggering;
}

// make dust / spark particles, play sound, for range
if isRanged && !hasSetAlarm {
	global.damageType = other.material == METAL ? "Block" : "Dust";
	if isSpell {
		global.damageType = spellElement;
	}
	global.x1 = x + lengthdir_x(bbox_right-bbox_left,facingDirection);
	global.y1 = bbox_bottom;
	global.particleDirection = facingDirection;
	instance_create_depth(0,0,1,obj_hit_particles);
	alarm[0] = 15;
	visible = 0;
	speed = 0;
	hasSetAlarm = true;
	if !isSpell {
		var snd = other.material == METAL ? snd_wallhit : snd_shield_hit_wood;
		audio_play_sound_at(snd,global.x1,global.y1,depth,20,200,1,0,1);
	} else {
		audio_stop_sound(sound);
		var snd = asset_get_index("snd_magic_"+owner.currentSpellAttunement+"_hit");
		audio_play_sound_at(snd,global.x1,global.y1,depth,20,200,1,0,1);
	}
}

if isSpell && !hasSetAlarm {
	var attunement = MAGIC;
	for (var i = 0; i < array_length_1d(global.ALL_ELEMENTS); i++) {
		var el = global.ALL_ELEMENTS[i];
		var arr = ds_map_find_value(spell.damages,el);
		if arr[1] != 0 {
			attunement = global.ALL_ELEMENTS[i];
		}
	}
	global.damageType = attunement;
	global.x1 = x + lengthdir_x(bbox_right-bbox_left,facingDirection);
	global.y1 = bbox_bottom;
	global.particleDirection = facingDirection;
	instance_create_depth(0,0,1,obj_hit_particles);
	//instance_destroy(id,true);
	alarm[0] = 15;
	visible = 0;
	speed = 0;
	x = global.x1;
	y = global.y1;
	hasSetAlarm = true;
}

if /*isSpell ||*/ isRanged && !hasSetAlarm {
	var idd = id;
	with obj_light_radius {
		if owner == idd {
			instance_destroy(id);
		}
	}
	
}