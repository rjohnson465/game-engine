var p = global.player;

var interactInputReceived = keyboard_check_released(ord("F"));
if gamepad_is_connected(global.player.gamePadIndex) {
	interactInputReceived = keyboard_check_released(ord("F")) || 
	(gamepad_button_check_pressed(global.player.gamePadIndex,gp_face1) && !global.ui.isShowingMenus)
}

var isInConvo = false;
with obj_npc_parent {
	if isInConversation isInConvo = true;
}
if !isActive {
	 maybeAddOrRemoveFromInteractablesList(20);
}
if	p.currentInteractableObject == id &&
	origLayer == p.layer && interactInputReceived && p.isAlive && !global.isLooting && !isInConvo {
	removeFromInteractablesList();
	isActive = true;
	updatePersistentElementProperty(id, "IsActive", isActive);
	audio_play_sound_at(snd_scrape_2, x, y, depth, 50, AUDIO_MAX_FALLOFF_DIST, 1, 0, 1);
} 

if isActive && (x != goalX || y != goalY) {
	move_towards_point(goalX, goalY, 8);
}

// burst particles, play sound, turn into bridge
if isActive && x == goalX && y == goalY {
	isActive = false;
	audio_play_sound_at(snd_crunchy_thud, x, y, depth, 50, AUDIO_MAX_FALLOFF_DIST, 1, 0, 1);
	
	global.bridgeSpriteIndex = sprite_index;
	global.bridgeAngle = image_angle;
			
	global.damageType = "Ground";
			
	global.x1 = x;
	global.y1 = y;
	global.particleDirection = 0;
	global.hitParticlesLayer = origLayer;
	global.victim = noone;
	instance_create_depth(x,y,1,obj_hit_particles);
	instance_change(obj_bridge_parent, 1);
	
}