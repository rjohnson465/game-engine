/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

// hat 

if state != CombatantStates.Dodging && getItemInEquipmentSlot(EquipmentSlots.Head) != noone {
	var hat = getItemInEquipmentSlot(EquipmentSlots.Head);
	var hatSprite = asset_get_index("spr_player_"+hat.spriteName);
	draw_sprite_ext(hatSprite,1,x,y,scale,scale,facingDirection,c_white,alpha);
}
