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
draw_set_color(c_red);
draw_rectangle(x1,y1,x2,y2,false);

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
draw_set_color(c_green);
draw_rectangle(x1,y1,x2,y2,false);

// xp
var xpPercent = (global.player.xp / global.player.xpToNextLevel)*100;
draw_healthbar(0,view_get_hport(view_camera[0])-5,view_get_wport(view_camera[0]),view_get_hport(view_camera[0]),xpPercent,c_black,c_white,c_white,0,true,true);

// current equipped items / spells
var leftHandItem = getItemInEquipmentSlot(EquipmentSlots.LeftHand1);
var leftHandItem2 = getItemInEquipmentSlot(EquipmentSlots.LeftHand2);
var rightHandItem = getItemInEquipmentSlot(EquipmentSlots.RightHand1);
var rightHandItem2 = getItemInEquipmentSlot(EquipmentSlots.RightHand2);

// left hand
draw_sprite_ext(spr_item_slot,1,10,698,1,1,0,c_white,.5);
if leftHandItem.spriteName != "unarmed" {
	var leftHandItemSprite = asset_get_index("spr_item_"+leftHandItem.spriteName);
	draw_sprite(leftHandItemSprite,1,10,698);
	if leftHandItem.totalCharges != 0 {
		var s = string(leftHandItem.charges) + "/" + string(leftHandItem.totalCharges);
		draw_set_color(c_white);
		draw_set_font(font_main);
		draw_set_halign(fa_left);
		draw_text(10,725,s);
	}
}

// two handed, show left hand with grayed out right hand equip
if rightHandItem.isTwoHanded {
	var leftHandItemSprite = asset_get_index("spr_item_"+rightHandItem.spriteName);
	draw_sprite_ext(leftHandItemSprite,1,10,698,1,1,1,c_black,.75);
}

// middle button (spell)
draw_sprite_ext(spr_item_slot,1,80,698,1,1,0,c_white,.5);
var spell = asset_get_index("spr_item_"+global.player.currentSpell+"_"+global.player.currentSpellAttunement);
if rightHandItem.charges != 0 || leftHandItem.charges != 0 {
	draw_sprite(spell,1,80,698);
} else {
	draw_sprite_ext(spell,1,80,698,1,1,0,c_gray,.75);
}

// right hand
draw_sprite_ext(spr_item_slot,1,150,698,1,1,0,c_white,.5);
if rightHandItem.spriteName != "unarmed" {
	var rightHandItemSprite = asset_get_index("spr_item_"+rightHandItem.spriteName);
	draw_sprite(rightHandItemSprite,1,150,698);

	if rightHandItem.totalCharges != 0 {
		var s = string(rightHandItem.charges) + "/" + string(rightHandItem.totalCharges);
		draw_set_color(c_white);
		draw_set_font(font_main);
		draw_set_halign(fa_left);
		draw_text(150,750,s);
		//script_execute(scr_draw_text_outline,150,750,s,c_black);
	}
}

// draw attunements
if rightHandItem.totalCharges > 0 || leftHandItem.totalCharges > 0 {
	
	instance_activate_object(obj_attunement);
	
	var init_x = 12; // changes on each iteration
	global.y1 = 658; // used for attunement instance creation
	for (var i = 0; i < array_length_1d(global.ALL_ELEMENTS); i++) {
		var el = global.ALL_ELEMENTS[i];
		var attunementSpriteIndex = asset_get_index("spr_attunement_"+el);
		var x1 = init_x + (i*40);
		
		if global.player.currentSpellAttunement != el {
			draw_sprite_ext(attunementSpriteIndex,1,x1,660,1,1,0,c_gray,.75);
		} else {
			draw_sprite_ext(attunementSpriteIndex,1,x1,660,1,1,0,c_white,1);
		}
		if !gamepad_is_connected(global.player.gamePadIndex) {
			script_execute(scr_draw_text_outline,x1+1,661,string(i+1),c_white,c_white);
		}
	}
} else {
	instance_deactivate_object(obj_attunement);
}

// menus
if isShowingMenus {
	
	// big menu screen
	draw_set_color(c_gray);
	draw_set_alpha(.75);
	draw_rectangle(MENUS_TOPLEFT_X,MENUS_TOPLEFT_Y,MENUS_BOTTOMRIGHT_X,MENUS_BOTTOMRIGHT_Y,c_black);
	
	// current menu title handle
	draw_set_color(c_olive);
	draw_rectangle(MENUS_TOPLEFT_X,MENUS_TOPLEFT_Y,MENUS_BOTTOMRIGHT_X,MENUS_TOPLEFT_Y+menusHandleHeight,false);
	// current menu title / hotkey text
	draw_set_color(c_white);
	draw_set_halign(fa_center);
	draw_set_font(font_main);
	var s = currentMenu +  " (" +ds_map_find_value(menuHotKeys,currentMenu) + ")";
	draw_text((MENUS_BOTTOMRIGHT_X+MENUS_TOPLEFT_X)/2,((MENUS_TOPLEFT_Y+menusHandleHeight)+MENUS_TOPLEFT_Y)/2,s);
	var closeButtonWidth = sprite_get_width(spr_close_button);
	draw_sprite(spr_close_button,1,MENUS_BOTTOMRIGHT_X-closeButtonWidth,MENUS_TOPLEFT_Y);
	
	// menu category tabs (3)
	var tabWidth = menusWidth / array_length_1d(menuTypes);
	var xx = MENUS_TOPLEFT_X;
	var yy = MENUS_TOPLEFT_Y+menusHandleHeight;
	for (var i = 0; i < array_length_1d(menuTypes); i++) {
		var x1 = xx + (i*tabWidth);
		var el = menuTypes[i];
		
		if currentMenu != el {
			draw_set_color(c_gray);
			draw_rectangle(x1,yy,x1+tabWidth,yy+menuTabsHeight,true);			
		} else {
			draw_set_color(c_ltgray);
			draw_rectangle(x1,yy,x1+tabWidth,yy+menuTabsHeight,true);
		}
		draw_text((x1+(x1+tabWidth))/2,((yy+menuTabsHeight)+yy)/2,el);
	}

	
}
