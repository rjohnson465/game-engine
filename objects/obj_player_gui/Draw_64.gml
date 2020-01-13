if room == game_menu exit;
draw_set_alpha(1);
var vx = camera_get_view_x(view_camera[0]);
var vy = camera_get_view_y(view_camera[0]);

// lock on target
if instance_exists(global.player.lockOnTarget) {
	if (global.player.isLockedOn && global.player.lockOnTarget != noone) {
		var rot = (alarm[0]/60)*360;
		draw_sprite_ext(spr_lockon,1,global.player.lockOnTarget.x-vx, global.player.lockOnTarget.y-vy,1,1,rot,c_white,1);
	}
} else global.player.lockOnTarget = noone;

var pad = global.player.gamePadIndex;
var p = global.player;

draw_set_font(font_main);
with obj_quest_log {
	if watchedQuest != noone && instance_exists(watchedQuest) && ds_exists(watchedQuest.questSteps,ds_type_list) {
		// is the HUD showing (clickable shit for menus for m/k?)
		var yy = 15;
		if !gamepad_is_connected(pad) {
			yy += sprite_get_height(spr_hud_inventory)+30;
		}
		var xl = view_get_wport(view_camera[0])-(4.5*sprite_get_width(spr_hud_inventory)); var xr = view_get_wport(view_camera[0])-15;
		var xx = mean(xl,xr);
		var xw = xr-xl;
		draw_set_halign(fa_center); draw_set_valign(fa_top);
		draw_set_font(font_main); draw_set_color(c_white);
		scr_draw_text_outline_ext(xx, yy, watchedQuest.name, c_fuchsia, c_silver, 1.25, 1.25, 0, c_black, -1, xw);
		var titleHeight = string_height_ext(watchedQuest.name, -1, xw);
	
		if !watchedQuest.isFinished && watchedQuest.currentQuestStep != noone {
			scr_draw_text_outline_ext(xx,yy+titleHeight+15,watchedQuest.currentQuestStep.description,c_ltgray,c_white,1,1,0,c_black,-1,xw);
		} else {
			scr_draw_text_outline_ext(xx,yy+titleHeight+15,"Quest complete!",c_ltgray,c_white,1,1,0,c_black,-1,xw);
		}
	
	}
}

var slotWidth = sprite_get_width(spr_item_slot);

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
	draw_set_color(c_white); draw_set_font(font_small); draw_set_halign(fa_center); draw_set_valign(fa_center);
	var s = "Health: " + string(round(global.player.hp)) + "/" + string(round(global.player.maxHp));
	var sh = string_height(s); 	var ys = 1;
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
	var s = "Stamina: " + string(round(global.player.stamina)) + "/" + string(round(global.player.maxStamina));
	var sh = string_height(s); 	var ys = 1;
	scr_draw_text_outline(mean(x1,x2),mean(y1,y2),s,c_white,c_white,ys,ys,0,c_black);
}

// poise 
var doDrawPoise = ds_map_find_value(global.optionsManager.optionsMapDisplay, OPT_D_PLAYERPOISE);
if doDrawPoise {
	var poiseAmount = (global.player.poiseCurrent / global.player.poiseMax) * 100;
	draw_set_color(c_white);
	draw_rectangle(x1, y2, x2, y2+5, true);
	var poiseColor = global.player.state == CombatantStates.Staggering ? c_gray : C_POISE;
	draw_healthbar(x1, y2+1, x2, y2+6, poiseAmount, c_black, poiseColor, poiseColor, 0, false, false);
	if point_in_rectangle(mouse_x,mouse_y,vx+x1,vy+y2,vx+x2,vy+y2+5) {
		draw_set_color(c_white); draw_set_font(font_small); draw_set_halign(fa_center);
		var s = "Poise: " + string(round(global.player.poiseCurrent)) + "/" + string(round(global.player.poiseMax));
		var sh = string_height(s); 	var ys = 1;
		scr_draw_text_outline(mean(x1,x2),mean(y2,y2+5),s,c_white,c_white,ys,ys,0,c_black);
	}
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
var rightHandItem = getItemInEquipmentSlot(EquipmentSlots.RightHand1);
var isDrawingAttunements = rightHandItem.chargesMax > 0 || leftHandItem.chargesMax > 0;

// left hand
var vh = view_get_hport(view_camera[0]);
draw_sprite_ext(spr_item_slot,1,10,vh-70,1,1,0,c_white,.5);
if leftHandItem.spriteName != "unarmed" {
	drawItem(leftHandItem, 10, vh-70, false, 1, 1, false);
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
// left hand prompts
if (gamepad_is_connected(pad)) {
	draw_sprite_ext(spr_prompt_xbox_lb,1,10,vh-70, .2, .2, 0, c_white, .6);
	if !p.isHoldingAttunemntSwapMode {
		draw_sprite_ext(spr_prompt_xbox_pad_l,1,10, vh-35, .2, .2, 0, c_white, .6);
	}
} else {
	draw_sprite_ext(spr_prompt_mk_lb,1,10,vh-70, .2, .2, 0, c_white, .6);
	draw_sprite_ext(spr_prompt_mk_q,1,10, vh-35, .2, .2, 0, c_white, .6);
}

// middle button (spell if m/k, item if controller)
draw_sprite_ext(spr_item_slot,1,80,vh-70,1,1,0,c_white,.5);
if gamepad_is_connected(pad) {
	// draw the current belt item
	var beltItemCurrent = p.beltItems[p.currentBeltItemIndex];
	if beltItemCurrent != noone && beltItemCurrent != undefined && instance_exists(beltItemCurrent) {
		drawItem(beltItemCurrent, 80, vh-70, 0, 1, 1, 0);
	}
	draw_sprite_ext(spr_prompt_xbox_x,1,125,vh-70, .2, .2, 0, c_white, .6);
	if !p.isHoldingAttunemntSwapMode {
		draw_sprite_ext(spr_prompt_xbox_pad_ud,1, 100, vh-26, .2, .2, 0, c_white, .6);
	}
}
// m/k middle slot
else if isDrawingAttunements {

	var spell = asset_get_index("spr_item_"+global.player.currentSpell+"_"+global.player.currentSpellAttunement);
	if rightHandItem.charges != 0 || leftHandItem.charges != 0 {
		draw_sprite(spell,1,80,vh-70);
	} else {
		draw_sprite_ext(spell,1,80,vh-70,1,1,0,c_gray,.75);
	}
	// spell prompt
	if (gamepad_is_connected(pad) && (rightHandItem.charges != 0 || leftHandItem.charges != 0)) {
		draw_sprite_ext(spr_prompt_xbox_lt,1,80,vh-70, .2, .2, 0, c_white, .6);
		if !p.isHoldingAttunemntSwapMode {
			draw_sprite_ext(spr_prompt_xbox_pad_ud,1, 100, vh-26, .2, .2, 0, c_white, .6);
		}
	} else if rightHandItem.charges != 0 || leftHandItem.charges != 0 {
		draw_sprite_ext(spr_prompt_mk_mb,1,80,vh-70, .2, .2, 0, c_white, .6);
	}
}

// right hand
draw_sprite_ext(spr_item_slot,1,150,vh-70,1,1,0,c_white,.5);
if rightHandItem.spriteName != "unarmed" {
	var rightHandItemSprite = asset_get_index("spr_item_"+rightHandItem.spriteName);
	// draw_sprite(rightHandItemSprite,1,150,vh-70);
	drawItem(rightHandItem, 150, vh-70, false, 1, 1, 0);
	if rightHandItem.chargesMax != 0 {
		var chargesPercent = (rightHandItem.charges / rightHandItem.chargesMax)*100;
		draw_healthbar(150,vh-12,211,vh-9,chargesPercent,c_black,C_HANDLES,c_aqua,0,1,0);
	}
	// ammo bar
	if rightHandItem.isRanged {
		var ammoPercent = (rightHandItem.ammo / rightHandItem.ammoMax)*100;
		draw_healthbar(150,vh-9,211,vh-6,ammoPercent,c_black,c_green,c_lime,0,1,0);
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

// right hand prompts
if (gamepad_is_connected(pad)) {
	var promptWidth = sprite_get_width(spr_prompt_xbox_rb) * .2;
	var px = (150 + slotWidth) - promptWidth;
	draw_sprite_ext(spr_prompt_xbox_rb,1,px,vh-70, .2, .2, 0, c_white, .6);
	if !p.isHoldingAttunemntSwapMode {
		draw_sprite_ext(spr_prompt_xbox_pad_r,1,px, vh-35, .2, .2, 0, c_white, .6);
	}
} else {
	var promptWidth = sprite_get_width(spr_prompt_xbox_rb) * .2;
	var px = (150 + slotWidth) - promptWidth;
	draw_sprite_ext(spr_prompt_mk_rb,1,px,vh-70, .2, .2, 0, c_white, .6);
	draw_sprite_ext(spr_prompt_mk_e,1,px, vh-35, .2, .2, 0, c_white, .6);
}


// show belt items, mouse/keyboard
// -- show this under attunements, since it is always there
// draw belt

var bScale = .625; // draw items at .625 scale, so they line up with attunements
var bSlotWidth = slotWidth * bScale;
global.gameManager.isMouseOverBelt = false;
var attunementsY = gamepad_is_connected(pad) ? vh - 108 : vh - 108 - bSlotWidth;

if !gamepad_is_connected(pad) {
	
	var y1 = vh - 108;
	var initX = 12;

	for (var i = 0; i < array_length_1d(p.beltItems); i++) {
		var x1 = initX + (i * bSlotWidth); 
		var item = p.beltItems[i];
		
		var alpha = .75;
		if mouseOverGuiRect(x1, y1, x1 + bSlotWidth, y1 + bSlotWidth) {
			global.gameManager.isMouseOverBelt = true;
			alpha = 1;
			p.currentBeltItemIndex = i;
			
			// any mouse click will use item
			if mouse_check_button_pressed(mb_left) || mouse_check_button_pressed(mb_right) {
				with p {
					performUseBeltItem();
				}
			}
			
			if mouse_check_button_pressed(mb_middle) {
				unequipBeltItem(i);
			}
		}
		
		draw_sprite_ext(spr_item_slot, 1, x1, y1, bScale, bScale, 0, c_white, alpha);
		if (item != undefined && item != noone && item > 0 && instance_exists(item)) {
			drawItem(item, x1, y1, 1, bScale, alpha, 0);
		}
		
		draw_set_font(font_damage); draw_set_valign(fa_bottom); draw_set_halign(fa_left);
		scr_draw_text_outline(x1, y1 + bSlotWidth, string(i+1), c_white, c_white);
	}
} 

// draw 
if isDrawingAttunements {
	
	var init_x = 12; // changes on each iteration
	var final_x = init_x + (array_length_1d(global.ALL_ELEMENTS)*sprite_get_width(spr_attunement_fire));
	global.y1 = 658; // used for attunement instance creation
	for (var i = 0; i < array_length_1d(global.ALL_ELEMENTS); i++) {
		var el = global.ALL_ELEMENTS[i];
		var attunementSpriteIndex = asset_get_index("spr_attunement_"+el);
		var x1 = init_x + (i*40);
		
		if global.player.currentSpellAttunement != el {
			var sw = sprite_get_width(attunementSpriteIndex);
			if point_in_rectangle(mouse_x,mouse_y,vx+x1,vy+attunementsY,vx+x1+sw,vy+attunementsY+sw) || global.player.isHoldingAttunemntSwapMode {
				draw_sprite_ext(attunementSpriteIndex,1,x1,attunementsY,1,1,0,c_white,1);
				draw_sprite_ext(attunementSpriteIndex,1,x1,attunementsY,1,1,0,c_gray,.75);
			} else {
				draw_sprite_ext(attunementSpriteIndex,1,x1,attunementsY,1,1,0,c_gray,.75);
			}
		} else {
			draw_sprite_ext(attunementSpriteIndex,1,x1,attunementsY,1,1,0,c_white,1);
		}
		// draw attunements hotkeys, if m/k
		if !gamepad_is_connected(pad) {
			draw_set_font(font_damage);
			draw_set_halign(fa_left); draw_set_valign(fa_top);
			var c2 = c_white;
			switch i {
				case 0: {
					c2 = c_aqua; break;
				}
				case 1: {
					c2 = c_orange; break;
				}
				case 2: {
					c2 = c_silver; break;
				}
				case 3: {
					c2 = c_lime; break;
				}
				case 4: {
					c2 = c_fuchsia; break;
				}
			}
			script_execute(scr_draw_text_outline,x1+1,attunementsY-2, "F" + string(i+1),c_white,c2);
		}
	}
	
	// draw an outline if holding rt (in attunement swap mode)
	if global.player.isHoldingAttunemntSwapMode {
		var yyy = vh-108; var yyy2 = yyy + sprite_get_height(spr_attunement_fire);
		draw_set_color(c_white);
		draw_rectangle(init_x, attunementsY, final_x, yyy2, 1);
		
		// draw pad lr prompt
		draw_sprite_ext(spr_prompt_xbox_pad_lr,1,mean(init_x,final_x)-5, attunementsY-35, .2, .2, 0, c_white, 1);
	}
}

// draw the current spell
// the current spell is on the left side of the attunement bar, a bit above
if gamepad_is_connected(pad) && isDrawingAttunements {
	var shownSpellY = attunementsY-bSlotWidth-5;
	var shownSpellX = 10;
	var spell = asset_get_index("spr_item_"+p.currentSpell+"_"+p.currentSpellAttunement);
	var nextSpellHeight = bSlotWidth / 2;
		
	var alpha = 0;
	if p.isHoldingAttunemntSwapMode {
		alpha = 1;
		// show main spell slot a bit higher up, since we'll show the next spells (above + below)
		shownSpellY -= nextSpellHeight;
	} else {
		alpha = .75;
		// draw right trigger prompt (to enter swap item / attunement mode)
		draw_sprite_ext(spr_prompt_xbox_rt,1,shownSpellX + bSlotWidth + 10, mean(shownSpellY, shownSpellY + bSlotWidth), .2, .2, 0, c_white, .6);
	}
	draw_sprite_ext(spr_item_slot, 1, shownSpellX, shownSpellY, bScale, bScale, 0, c_white, alpha);
	if (spell != undefined && spell != noone && spell > 0) {
		if leftHandItem.charges != 0 || rightHandItem.charges != 0 {
			draw_sprite_ext(spell, 1, shownSpellX, shownSpellY, bScale, bScale, 0, c_white, 1);
		} else {
			draw_sprite_ext(spell,1,shownSpellX,shownSpellY,bScale,bScale,0,c_gray,.75);
		}
		// draw lt prompt to cast this spell
		draw_sprite_ext(spr_prompt_xbox_lt,1,shownSpellX, shownSpellY, .2, .2, 0, c_white, .6);
		
		if p.isHoldingAttunemntSwapMode {
			var spellObj = ds_map_find_value(p.knownSpells, p.currentSpell);
			var spellName = spellObj.name;
			var c2 = c_white;
			switch p.currentSpellAttunement {
				case MAGIC: {
					c2 = c_aqua; break;
				}
				case FIRE: {
					c2 = c_orange; break;
				}
				case ICE: {
					c2 = c_silver; break;
				}
				case POISON: {
					c2 = c_lime; break;
				}
				case LIGHTNING: {
					c2 = c_fuchsia; break;
				}
			}
			draw_set_font(font_damage); draw_set_halign(fa_left);
			scr_draw_text_outline(shownSpellX, shownSpellY - nextSpellHeight - 20, spellName, c_white, c2);
		}
	}
	
	if p.isHoldingAttunemntSwapMode {
		// draw the next spell
		var maybeNext = ds_map_find_next(p.knownSpells,p.currentSpell);
		var nextSpellName = "";
		if is_undefined(maybeNext) {
			nextSpellName = ds_map_find_first(p.knownSpells);
		} else {
			nextSpellName = maybeNext;
		}
		var nextSpellSpr = asset_get_index("spr_item_"+nextSpellName+"_"+p.currentSpellAttunement);
		draw_sprite_ext(spr_item_slot, 1, shownSpellX+(.5*bSlotWidth), shownSpellY+bSlotWidth, bScale / 2, bScale / 2, 0, c_white, alpha);
		if (nextSpellSpr != undefined && nextSpellSpr != noone && nextSpellSpr > 0) {
			draw_sprite_ext(nextSpellSpr, 1, shownSpellX+(.5*bSlotWidth), shownSpellY+bSlotWidth, bScale / 2, bScale / 2, 0, c_white, alpha);
		}
		
		// draw the prev spell
		var maybePrev = ds_map_find_previous(p.knownSpells,p.currentSpell);
		var prevSpellName = "";
		if is_undefined(maybePrev) {
			prevSpellName = ds_map_find_last(p.knownSpells);
		} else {
			prevSpellName = maybePrev;
		}
		var prevSpellSpr = asset_get_index("spr_item_"+prevSpellName+"_"+p.currentSpellAttunement);
		draw_sprite_ext(spr_item_slot, 1, shownSpellX+(.5*bSlotWidth), shownSpellY-nextSpellHeight, bScale / 2, bScale / 2, 0, c_white, alpha);
		if (prevSpellSpr != undefined && prevSpellSpr != noone && prevSpellSpr > 0) {
			draw_sprite_ext(prevSpellSpr, 1, shownSpellX+(.5*bSlotWidth), shownSpellY-nextSpellHeight, bScale / 2, bScale / 2, 0, c_white, alpha);
		}
		
		// draw pad up/down prompt
		draw_sprite_ext(spr_prompt_xbox_pad_ud,1,shownSpellX + bSlotWidth + 10, mean(shownSpellY, shownSpellY + bSlotWidth)-5, .2, .2, 0, c_white, 1);
	}
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
	draw_set_halign(fa_center); draw_set_valign(fa_center);
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
		
		// if we have completed quests not yet cashed in, alert
		if el == SKILLS && playerId.questsAtRewardStepCount > 0 {
			var numQuestsAtRewardStep = playerId.questsAtRewardStepCount;
			draw_set_color(c_purple);
			var x3 = x1 + tabWidth - 15;
			draw_circle(x3,mean(yy,yy+menuTabsHeight),10,0);
			draw_set_color(c_white);
			draw_text(x3,mean(yy,yy+menuTabsHeight),numQuestsAtRewardStep);
		}
	}

	
}
draw_set_alpha(1);

