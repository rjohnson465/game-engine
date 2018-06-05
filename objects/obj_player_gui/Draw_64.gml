//display_set_gui_size(-1, -1);

var vx = camera_get_view_x(view_camera[0]);
var vy = camera_get_view_y(view_camera[0]);

draw_set_valign(fa_center);
// hit points
var x1 = 10;
var y1 = 10;
var x2 = 210;
var y2 = 20;
draw_set_color(c_white);
draw_rectangle(x1,y1,x2,y2,true);
var percentHpLeft = global.player.hp/global.player.maxHp;
x2 = x1 + (200 * percentHpLeft);
if x2 < x1 {
	x2 = x1;
}
//draw_set_color(c_red);
draw_rectangle_color(x1,y1,x2,y2,c_red,c_red,c_maroon,c_maroon,false);

// show currently lost / losing hp in yellow?
var sustainingDamageObj = noone;
var playerId = global.player.id;
with (obj_damage) {
	if victim == playerId {
		sustainingDamageObj = id;
	}
}
if sustainingDamageObj {
		
	// this is how much hp the enemy had when the first damage in this group was leveled against it
	var healingSustained = sustainingDamageObj.healingSustained;
		
	var sustainingDamage = sustainingDamageObj.amount;
	// top right corner of current hp bar
	var sustainingDamageLeftX = x2;
	var percentOfTotal = sustainingDamage / global.player.maxHp;
	var sustainingDamageRightX = sustainingDamageLeftX + (200 * percentOfTotal);
		
	// offset the damage right x to account for any hp regen or healing
	if healingSustained > 0 {
		var deltaPercent = healingSustained / global.player.maxHp;
		var xOff = 200 * deltaPercent;
		sustainingDamageRightX -= xOff;
	}
		
	if sustainingDamageRightX > 210 {
		sustainingDamageRightX = 210;
	}
		
	draw_set_color(c_ltgray);
	draw_rectangle(sustainingDamageLeftX,10,sustainingDamageRightX,20,false);
}

var x1 = 10;
var y1 = 10;
var x2 = 210;
var y2 = 20;
if point_in_rectangle(mouse_x,mouse_y,vx+x1,vy+y1,vx+x2,vy+y2) {
	draw_set_color(c_white); draw_set_font(font_small); draw_set_halign(fa_center);
	var s = string(round(global.player.hp)) + "/" + string(round(global.player.maxHp));
	var sh = string_height(s); 	var ys = 1;
	//if sh > (y2-y1) ys = (y2-y1)/sh;
	//draw_text_transformed(mean(x1,x2),mean(y1,y2),s,ys,ys,0);
	scr_draw_text_outline(mean(x1,x2),mean(y1,y2),s,c_white,c_white,ys,ys,0,c_black);
}

// stamina
var x1 = 10;
var y1 = 20;
var x2 = 210;
var y2 = 30;
draw_set_color(c_white);
draw_rectangle(x1,y1,x2,y2,true);
var percentHpLeft = global.player.stamina/global.player.maxStamina;
x2 = x1 + (200 * percentHpLeft);
if x2 < x1 {
	x2 = x1;
}
//draw_set_color(c_green);
draw_rectangle_color(x1,y1,x2,y2,c_lime,c_lime,c_green,c_green,false);

var x1 = 10;
var y1 = 20;
var x2 = 210;
var y2 = 30;
if point_in_rectangle(mouse_x,mouse_y,vx+x1,vy+y1,vx+x2,vy+y2) {
	draw_set_color(c_white); draw_set_font(font_small); draw_set_halign(fa_center);
	var s = string(round(global.player.stamina)) + "/" + string(round(global.player.maxStamina));
	var sh = string_height(s); 	var ys = 1;
	//if sh > (y2-y1) ys = (y2-y1)/sh;
	//draw_text_transformed(mean(x1,x2),mean(y1,y2),s,ys,ys,0);
	scr_draw_text_outline(mean(x1,x2),mean(y1,y2),s,c_white,c_white,ys,ys,0,c_black);
}

// xp bar
var xpPercent = (global.player.xp / global.player.xpToNextLevel)*100;
draw_healthbar(0,view_get_hport(view_camera[0])-5,view_get_wport(view_camera[0]),view_get_hport(view_camera[0]),xpPercent,c_black,C_HANDLES,C_HANDLES,0,true,true);
var xpBarRightX = (xpPercent/100)*view_get_wport(view_camera[0]);
var xpTemp = global.player.xpTemp;
var xpTempTotal = global.player.xpToNextLevel-global.player.xp;
var xpTempPercent = (xpTemp/xpTempTotal)*100;
draw_healthbar(xpBarRightX,view_get_hport(view_camera[0])-5,view_get_wport(view_camera[0]),view_get_hport(view_camera[0]),xpTempPercent,c_black,c_aqua,c_aqua,0,1,1);

var x1 = 10;
var y1 = 20;
var x2 = 210;
var y2 = 30;
if point_in_rectangle(mouse_x,mouse_y,
	vx+0,
	vy+view_get_hport(view_camera[0])-5,
	vx+view_get_wport(view_camera[0]),
	vy+view_get_hport(view_camera[0]))
	{
		draw_set_halign(fa_right); draw_set_font(font_main);
		var s = "XP: " + string(round(global.player.xpTemp+global.player.xp))+"/"+string(round(global.player.xpToNextLevel));
		var sw = string_width(s); var sh = string_height(s);
		var xx = view_get_wport(view_camera[0]); var yy = view_get_hport(view_camera[0])-15
		draw_set_color(c_white); 
		draw_text(xx,yy,s);
	}

// current equipped items / spells
var leftHandItem = getItemInEquipmentSlot(EquipmentSlots.LeftHand1);
var leftHandItem2 = getItemInEquipmentSlot(EquipmentSlots.LeftHand2);
var rightHandItem = getItemInEquipmentSlot(EquipmentSlots.RightHand1);
var rightHandItem2 = getItemInEquipmentSlot(EquipmentSlots.RightHand2);

// left hand
var vh = view_get_hport(view_camera[0]);
draw_sprite_ext(spr_item_slot,1,10,vh-70,1,1,0,c_white,.5);
if leftHandItem.spriteName != "unarmed" {
	var leftHandItemSprite = asset_get_index("spr_item_"+leftHandItem.spriteName);
	draw_sprite(leftHandItemSprite,1,10,vh-70);
	if leftHandItem.chargesMax != 0 {
		var chargesPercent = (leftHandItem.charges / leftHandItem.chargesMax)*100;
		draw_healthbar(10,vh-12,71,vh-9,chargesPercent,c_black,C_HANDLES,c_aqua,0,1,0);
	}
	// ammo bar
	if leftHandItem.isRanged {
		var ammoPercent = (leftHandItem.ammo / leftHandItem.ammoMax)*100;
		draw_healthbar(10,vh-9,71,vh-6,ammoPercent,c_black,c_green,c_lime,0,1,0);
	}
	// durability bar
	else {
		var durabilityPercent = (leftHandItem.durability / leftHandItem.durabilityMax)*100;
		draw_healthbar(10,vh-9,71,vh-6,durabilityPercent,c_black,c_maroon,c_red,0,1,0);
	}
}

// middle button (spell)
draw_sprite_ext(spr_item_slot,1,80,vh-70,1,1,0,c_white,.5);
var spell = asset_get_index("spr_item_"+global.player.currentSpell+"_"+global.player.currentSpellAttunement);
if rightHandItem.charges != 0 || leftHandItem.charges != 0 {
	draw_sprite(spell,1,80,vh-70);
} else {
	draw_sprite_ext(spell,1,80,vh-70,1,1,0,c_gray,.75);
}

// right hand
draw_sprite_ext(spr_item_slot,1,150,vh-70,1,1,0,c_white,.5);
if rightHandItem.spriteName != "unarmed" {
	var rightHandItemSprite = asset_get_index("spr_item_"+rightHandItem.spriteName);
	draw_sprite(rightHandItemSprite,1,150,vh-70);

	if rightHandItem.chargesMax != 0 {
		var chargesPercent = (rightHandItem.charges / rightHandItem.chargesMax)*100;
		draw_healthbar(150,vh-12,211,vh-9,chargesPercent,c_black,C_HANDLES,c_aqua,0,1,0);
	}
	// ammo bar
	if rightHandItem.isRanged {
		var ammoPercent = (leftHandItem.ammo / leftHandItem.ammoMax)*100;
		draw_healthbar(150,vh-9,211,vh-6,durabilityPercent,c_black,c_green,c_lime,0,1,0);
	} else {
		// durability bar
		var durabilityPercent = (rightHandItem.durability / rightHandItem.durabilityMax)*100;
		draw_healthbar(150,vh-9,211,vh-6,durabilityPercent,c_black,c_maroon,c_red,0,1,0);
	}
}

// two handed, show right hand with grayed out left hand equip
if leftHandItem.isTwoHanded {
	var rightHandItemSprite = asset_get_index("spr_item_"+leftHandItem.spriteName);
	draw_sprite_ext(rightHandItemSprite,1,150,vh-70,1,1,1,c_black,.75);
}

// draw attunements
if rightHandItem.chargesMax > 0 || leftHandItem.chargesMax > 0 {
	
	//instance_activate_object(obj_attunement);
	
	var init_x = 12; // changes on each iteration
	global.y1 = 658; // used for attunement instance creation
	for (var i = 0; i < array_length_1d(global.ALL_ELEMENTS); i++) {
		var el = global.ALL_ELEMENTS[i];
		var attunementSpriteIndex = asset_get_index("spr_attunement_"+el);
		var x1 = init_x + (i*40);
		
		if global.player.currentSpellAttunement != el {
			var sw = sprite_get_width(attunementSpriteIndex);
			if point_in_rectangle(mouse_x,mouse_y,vx+x1,vy+vh-108,vx+x1+sw,vy+vh-108+sw) {
				draw_sprite_ext(attunementSpriteIndex,1,x1,vh-108,1,1,0,c_white,1);
				draw_sprite_ext(attunementSpriteIndex,1,x1,vh-108,1,1,0,c_gray,.75);
			} else {
				draw_sprite_ext(attunementSpriteIndex,1,x1,vh-108,1,1,0,c_gray,.75);
			}
		} else {
			draw_sprite_ext(attunementSpriteIndex,1,x1,vh-108,1,1,0,c_white,1);
		}
		if !gamepad_is_connected(global.player.gamePadIndex) {
			draw_set_font(font_damage);
			draw_set_halign(fa_left);
			script_execute(scr_draw_text_outline,x1+1,vh-107,string(i+1),c_white,c_white);
		}
	}
} else {
	//instance_deactivate_object(obj_attunement);
}

// menus
if isShowingMenus {
	
	// big menu screen
	draw_set_color(c_gray);
	draw_set_alpha(.75);
	draw_rectangle(MENUS_TOPLEFT_X,MENUS_TOPLEFT_Y,MENUS_BOTTOMRIGHT_X,MENUS_BOTTOMRIGHT_Y,c_black);
	draw_set_alpha(1);
	
	// current menu title handle
	draw_set_color(C_HANDLES);
	draw_rectangle(MENUS_TOPLEFT_X,MENUS_TOPLEFT_Y,MENUS_BOTTOMRIGHT_X,MENUS_TOPLEFT_Y+menusHandleHeight,false);
	// current menu title / hotkey text
	draw_set_color(c_white);
	draw_set_halign(fa_center);
	draw_set_font(font_main);
	var hotKey = gamepad_is_connected(global.player.gamePadIndex) ? "" : " (" + ds_map_find_value(menuHotKeys,currentMenu) + ")";
	var s = currentMenu + hotKey;
	draw_text((MENUS_BOTTOMRIGHT_X+MENUS_TOPLEFT_X)/2,((MENUS_TOPLEFT_Y+menusHandleHeight)+MENUS_TOPLEFT_Y)/2,s);
	if !gamepad_is_connected(global.player.gamePadIndex) {
		var closeButtonWidth = sprite_get_width(spr_close_button);
		var x1 = MENUS_BOTTOMRIGHT_X-closeButtonWidth; var x2 = x1 + closeButtonWidth;
		var y1 = MENUS_TOPLEFT_Y; var y2 = y1+closeButtonWidth;
		if point_in_rectangle(mouse_x,mouse_y,vx+x1,vy+y1,vx+x2,vy+y2) && mouse_check_button(mb_left) {
			draw_sprite_ext(spr_close_button,1,x1,y1,1,1,0,c_black,1);
		} else if point_in_rectangle(mouse_x,mouse_y,vx+x1,vy+y1,vx+x2,vy+y2) {
			draw_sprite_ext(spr_close_button,1,x1,y1,1,1,0,c_gray,1);
		} else {
			draw_sprite(spr_close_button,1,x1,y1);
		}
	}
	
	// menu category tabs (3)
	var tabWidth = 0;
	if gamepad_is_connected(global.player.gamePadIndex) {
		tabWidth = (menusWidth-(menuTabsHeight*2)) / array_length_1d(menuTypes); // (menuTabsHeight*2) allows 2 trigger prompts
	} else {
		tabWidth = menusWidth / array_length_1d(menuTypes);
	}
	var xx = MENUS_TOPLEFT_X;
	var yy = MENUS_TOPLEFT_Y+menusHandleHeight;
	if gamepad_is_connected(global.player.gamePadIndex) {
		xx = MENUS_TOPLEFT_X + menuTabsHeight;
		var scale = menuTabsHeight / sprite_get_height(spr_prompt_xbox_lt);
		draw_set_color(c_dkgray);
		draw_set_alpha(1);
		draw_rectangle(MENUS_TOPLEFT_X,yy,MENUS_TOPLEFT_X+menuTabsHeight,MENUS_TOPLEFT_Y+menusHandleHeight+menuTabsHeight,0);
		draw_sprite_ext(spr_prompt_xbox_lt,1,MENUS_TOPLEFT_X+menuTabsHeight-menuTabsHeight,yy,scale,scale,0,c_white,1);
		var rx = MENUS_BOTTOMRIGHT_X-menuTabsHeight;
		draw_rectangle(rx,yy,MENUS_BOTTOMRIGHT_X,MENUS_TOPLEFT_Y+menusHandleHeight+menuTabsHeight,0);
		draw_sprite_ext(spr_prompt_xbox_rt,1,rx,yy,scale,scale,0,c_white,1);
	}
	for (var i = 0; i < array_length_1d(menuTypes); i++) {
		var x1 = xx + (i*tabWidth);
		var el = menuTypes[i];
		draw_set_alpha(1);
		
		// draw actual tab "button"
		if point_in_rectangle(mouse_x,mouse_y,vx+x1,vy+yy,vx+x1+tabWidth,vy+yy+menuTabsHeight) && mouse_check_button(mb_left) {
			draw_set_color(c_black);
		} else if point_in_rectangle(mouse_x,mouse_y,vx+x1,vy+yy,vx+x1+tabWidth,vy+yy+menuTabsHeight) {	
			draw_set_color(C_DKRGRAY);
		} else {
			draw_set_color(c_dkgray);
		}
		draw_rectangle(x1,yy,x1+tabWidth,yy+menuTabsHeight,0);
		
		if currentMenu != el {
			draw_set_color(c_gray);
			draw_rectangle(x1,yy,x1+tabWidth,yy+menuTabsHeight,true);			
		} else {
			draw_set_color(c_ltgray);
			draw_rectangle(x1,yy,x1+tabWidth,yy+menuTabsHeight,true);
		}
		draw_text((x1+(x1+tabWidth))/2,((yy+menuTabsHeight)+yy)/2,el);
		
		// if we have skill points, alert
		if el == SKILLS && playerId.skillPoints > 0 {
			var numSkillPoints = playerId.skillPoints;
			draw_set_color(c_red);
			draw_circle(x1+15,mean(yy,yy+menuTabsHeight),10,0);
			draw_set_color(c_white);
			draw_text(x1+15,mean(yy,yy+menuTabsHeight),numSkillPoints);
		}
	}

	
}
draw_set_alpha(1);

/*
if global.ui.grabbedItem {
	with global.ui.grabbedItem {
		if grabFrame == grabFrames {
			var gw = window_get_width();
			var gh = window_get_height();
			var vw = view_get_wport(view_camera[0]);
			var vh = view_get_hport(view_camera[0]);
			var xs = gw/1280; var ys = gh/720;
	
			var xs = 1; var ys = 1;
	
			var vx = camera_get_view_x(view_camera[0]);
			var vy = camera_get_view_y(view_camera[0]);
			draw_sprite_ext(spr_item_slot,1,mouse_x-vx-32,mouse_y-vy-32,xs,ys,0,c_white,1);
			draw_sprite_ext(itemSprite,1,mouse_x-vx-32,mouse_y-vy-32,xs,ys,0,c_white,1);
	
			show_debug_message(string(gw) + "," + string(gh));
		}
	}
}