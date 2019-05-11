if room == game_menu {
	exit;
}/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();
shader_reset();

// hat 
if state != CombatantStates.Dodging && getItemInEquipmentSlot(EquipmentSlots.Head) != noone {
	var hat = getItemInEquipmentSlot(EquipmentSlots.Head);
	var hatSprite = asset_get_index("spr_player_"+hat.spriteName);
	draw_sprite_ext(hatSprite,1,x,y,scale,scale,facingDirection,c_white,alpha);
	
	
}

// also draw wings over hat?
var wingsSprite = state == CombatantStates.Moving ? spr_player_wings_move : spr_player_wings;
draw_sprite_ext(wingsSprite, image_index, x, y, scale, scale, facingDirection, c_white, 1);