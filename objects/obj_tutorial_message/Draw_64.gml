// if !isCurrentInteractionObject(id) exit;
if origLayer != global.player.layer exit;

var isInConvo = false;
with obj_npc_parent {
	if isInConversation isInConvo = true;
}

if	!isActive 
	// && distance_to_object(obj_player) < 20 
	&& global.player.currentInteractableObject == id 
	&& !global.isReadingTutorial && global.player.isAlive && !global.isLooting && !global.isWishing && !global.ui.isShowingMenus && !isInConvo {
	drawPrompt("Read message",Input.F, noone, noone, noone, noone, true);
}

if isActive && global.player.isAlive && !global.canLoot && !global.isWishing && !global.ui.isShowingMenus && !isInConvo {

	var xx = view_get_wport(view_camera[0]) / 2;
	var yy = view_get_hport(view_camera[0]) - 150;
	
	var sprites = gamepad_is_connected(global.gamePadIndex) ? promptSpritesController : promptSpritesMk;
	if array_length_1d(sprites) == 0 yy += sprite_get_height(spr_prompt_mk_backspace)*.35;
	var spriteHeight = 0; var spritesWidth = 0;
	for (var i = 0 ; i < array_length_1d(sprites); i++) {
		var sprite = sprites[i];
		spriteHeight = sprite_get_height(sprite)*.35;
		var sw = sprite_get_width(sprite)*.35;
		spritesWidth += (sw);
		
		// maybe include separator width
		if array_length_1d(promptSpritesSeparators) >= i + 1 {
			var separator = promptSpritesSeparators[i];
			var strW = string_width(separator);
			spritesWidth += strW;
		}
	}
	if spriteHeight != 0 spriteHeight += 5; // padding
	draw_set_font(font_main); 
	
	var sh = string_height_ext(message,-1,view_get_wport(view_camera[0])/2);
	var sw = string_width_ext(message,-1,view_get_wport(view_camera[0])/2);
	
	if spritesWidth > sw sw = spritesWidth;
	
	draw_set_color(c_black);
	draw_rectangle(xx-(.5*sw)-10,yy-(.5*sh)-10,xx+(.5*sw)+10,yy+(.5*sh)+spriteHeight+10,0);
	
	draw_set_color(c_aqua);
	draw_rectangle(xx-(.5*sw)-10,yy-(.5*sh)-10,xx+(.5*sw)+10,yy+(.5*sh)+spriteHeight+10,1);
	
	draw_set_color(c_white);
	// draw prompt sprites
	var spritesWidthCum = 0;
	var xxx = xx - (.5*spritesWidth);
	for (var i = 0 ; i < array_length_1d(sprites); i++) {
		var sprite = sprites[i];
		var sw = sprite_get_width(sprite)*.35;
		var sh = sprite_get_height(sprite)*.35;
		draw_sprite_ext(sprite,1,xxx+spritesWidthCum,yy-(.25*sh),.35,.35,0,c_white,1);
		spritesWidthCum += (sw);
		
		// maybe draw separator 
		if array_length_1d(promptSpritesSeparators) >= i + 1 && array_length_1d(sprites) != i + 1 {
			var separator = promptSpritesSeparators[i];
			var strW = string_width(separator);
			var yOff = separator == "," ? .5*sh : .25*sh;
			draw_text(xxx+spritesWidthCum,yy+yOff,separator);
			spritesWidthCum += strW;
		}
	}
	
	draw_set_halign(fa_center); draw_set_font(font_main); draw_set_valign(fa_center);
	draw_text_ext(xx,yy+spriteHeight,message,-1,view_get_wport(view_camera[0])/2);
	
	drawPrompt("OK", Input.F);
}