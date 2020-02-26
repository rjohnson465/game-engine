if global.isReadingTutorial exit;
var isInConvo = false;
with obj_npc_parent {
	if isInConversation isInConvo = true;
}
if	global.player.currentInteractableObject == id &&
	inventoryContainsItem(obj_item_clayheart) &&
	!isActive && global.player.isAlive && layer == global.player.layer && !isInConvo && !global.isInteractingWithNpc {
	drawPrompt("Awaken Hershel",Input.F, noone, noone, noone, noone, true);
}


if isActive && !isGoingToAri && !isWithAri {
	var vx = camera_get_view_x(view_camera[0]);
	var vy = camera_get_view_y(view_camera[0]);
	var spw = sprite_get_bbox_right(sprite_index)-sprite_get_bbox_left(sprite_index); 
	var sph = sprite_get_bbox_bottom(sprite_index)-sprite_get_bbox_top(sprite_index);
	var hpOutlineLeftX = (x-vx)-(.5*spw)-25;
	var hpOutlineTopY = (y-vy)-(.5*sph)-10;
	var hpOutlineRightX = (x-vx)+(.5*spw)+25;
	var hpOutlineBottomY = (y-vy)-(.5*sph)-5;
	
	var hbw = hpOutlineRightX - hpOutlineLeftX;
	draw_set_color(c_white);
	draw_rectangle(hpOutlineLeftX,hpOutlineTopY,hpOutlineRightX,hpOutlineBottomY,true);
	
	// current hp
	var percentHpLeft = hp / maxHp;
	var currentHpRightX = hpOutlineLeftX + (hbw * percentHpLeft);
	if (currentHpRightX < hpOutlineLeftX) currentHpRightX = hpOutlineLeftX;
	draw_set_color(c_orange);
	draw_rectangle(
		hpOutlineLeftX,
		hpOutlineTopY,
		currentHpRightX,
		hpOutlineBottomY,
		false);
}