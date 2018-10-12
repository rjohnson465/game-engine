event_inherited();
var p = global.player;
if p.rightHandItem.object_index != obj_hand_item_torch && !isLit {
	maybeRemoveObjectFromInteractionList(id);
	exit;
}
var interactInputReceived = keyboard_check_released(ord("F"));
if gamepad_is_connected(global.player.gamePadIndex) {
	interactInputReceived = keyboard_check_released(ord("F")) || 
	(gamepad_button_check_pressed(global.player.gamePadIndex,gp_face1) && !global.ui.isShowingMenus)
}

var isInConvo = false;
with obj_npc_parent {
	if isInConversation isInConvo = true;
}

var angleToSconce = point_direction(p.x,p.y,x,y);
var isFacing = angleBetween(p.facingDirection-45,p.facingDirection+45,angleToSconce);

if isFacing && distance_to_object(obj_player) < 20 && origLayer == p.layer && interactInputReceived && p.isAlive && !global.isLooting && !isInConvo {
	if !isLit && p.rightHandItem.object_index == obj_hand_item_torch {
		isLit = true;
		audio_emitter_gain(soundEmitter,MAXGAIN);
		updatePersistentElementProperty(id, "isLit", true);
		audio_play_sound_at(snd_magic_fire_shoot,x,y,depth,100,AUDIO_MAX_FALLOFF_DIST,1,0,1);
		global.owner = id;
		global.makeLightOnCreate = true;
		lightRadius = instance_create_depth(x,y,depth,obj_light_radius);
		with lightRadius {
			var floorNum = getLayerFloorNumber(other.origLayer);
			light_set_alpha(calculateLightRadiusAlphaLayer(floorNum));
		}
	}
	// extinguish flame
	else if isLit {
		isLit = false;
		audio_emitter_gain(soundEmitter,0);
		updatePersistentElementProperty(id, "isLit", false);
		audio_play_sound_at(snd_magic_fire_hit,x,y,depth,100,AUDIO_MAX_FALLOFF_DIST,1,0,1);
		// might need to do more to make the light radius fuck off
		instance_destroy(lightRadius,1);
		light_destroy_layer(getLayerFloorNumber(origLayer),lightRadius);
	}
} 