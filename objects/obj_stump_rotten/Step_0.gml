event_inherited();
var interactInputReceived = keyboard_check_released(ord("F"));
if gamepad_is_connected(global.player.gamePadIndex) {
	interactInputReceived = keyboard_check_released(ord("F")) || 
	(gamepad_button_check_pressed(global.player.gamePadIndex,gp_face1) && !global.ui.isShowingMenus)
}

var isInConvo = false;
with obj_npc_parent {
	if isInConversation isInConvo = true;
}
if global.isReadingTutorial exit;
var p = global.player;

if !isFallen {
	maybeAddOrRemoveFromInteractablesList(20);
}

if	global.player.currentInteractableObject == id 
	&& origLayer == p.layer && interactInputReceived && p.isAlive && !global.isLooting && !isInConvo {
	isFallen = true;
	removeFromInteractablesList();
	updatePersistentElementProperty(id,"isFallen",true);
	sprite_index = spr_stump_rotten_falling;
	audio_play_sound_at(fallingSound,x,y,depth,100,AUDIO_MAX_FALLOFF_DIST,1,0,1);
	light_destroy_caster_layer(getLayerFloorNumber(origLayer));
		
			
	global.damageType = "Dust";
	global.x1 = x;
	global.y1 = y;
	global.particleDirection = 0;
	global.hitParticlesLayer = origLayer;
	global.victim = noone;
	instance_create_depth(x,y,1,obj_hit_particles);
		
} 