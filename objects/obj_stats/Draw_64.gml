if !ui.isShowingMenus || ui.currentMenu != INVENTORY exit;

draw_set_color(c_black);
draw_rectangle(topLeftX,topLeftY,bottomRightX,bottomRightY,1);

var p = global.player;
var leftHandItem = ds_map_find_value(p.equippedLimbItems,"l");
var rightHandItem = ds_map_find_value(p.equippedLimbItems,"r");

var line = 0;

draw_set_valign(fa_top);
draw_set_halign(fa_center);
draw_set_font(font_main);
draw_set_color(c_ltgray);
draw_text(mean(topLeftX,topLeftX+width),topLeftY,"General");
line++;

draw_set_valign(fa_top); draw_set_halign(fa_left); 
draw_set_font(font_small);
draw_set_color(c_white);

// level / xp
draw_sprite(spr_stats_level,1,wdCol1XPictures,topLeftY+(line*20));
if ui.isShowingExplanations {
	draw_text(basicCol1XText,topLeftY+(line*20),"Player Level");
} else draw_text(basicCol1XText,topLeftY+(line*20),"Level: " + string(p.level));
// xp
draw_sprite(spr_stats_xp,1,basicCol2XPictures,topLeftY+(line*20));
if ui.isShowingExplanations {
	draw_text(basicCol2XText,topLeftY+(line*20),"XP/Next Level At");
} else draw_text(basicCol2XText,topLeftY+(line*20),"XP: "+string(p.xp+p.xpTemp) + "/" + string(p.xpToNextLevel));
line++;

// being affected by a lamplight gives bonus stamina and hp regen
var lamplightCondi = ds_map_find_value(p.conditionLevels, "spr_item_lamplight");
var llCondiExists = lamplightCondi != undefined && lamplightCondi > 0;

// hp
draw_sprite(spr_stats_hp,1,basicCol1XPictures,topLeftY+(line*20));
if ui.isShowingExplanations {
	draw_text(basicCol1XText,topLeftY+(line*20),"HP/Max HP");
} else draw_text(basicCol1XText,topLeftY+(line*20),"HP: "+string(round(p.hp)) + "/" + string(p.maxHp));
draw_sprite(spr_stats_hp_regen,1,basicCol2XPictures,topLeftY+(line*20));
if ui.isShowingExplanations {
	draw_text(basicCol2XText,topLeftY+(line*20),"HP regained/sec");
} else {
	var hpRegenText = llCondiExists ? string(p.hpRegen*2) : string(p.hpRegen);
	draw_text(basicCol2XText,topLeftY+(line*20),"Regen: "+hpRegenText);
}
line++;

// stamina
draw_sprite(spr_stats_stamina,1,wdCol1XPictures,topLeftY+(line*20));
if ui.isShowingExplanations {
	drawTextWidth(basicCol1XText,topLeftY+(line*20),"Stamina/Max Stamina",basicCol1Width-21);
} else draw_text(basicCol1XText,topLeftY+(line*20),"Stamina: "+string(round(p.stamina)) + "/" + string(p.maxStamina));
draw_sprite(spr_stats_stamina_regen,1,basicCol2XPictures,topLeftY+(line*20));
if ui.isShowingExplanations {
	drawTextWidth(basicCol2XText,topLeftY+(line*20),"Stamina regained/sec",basicCol1Width-21);
} else {
	var staminaRegenText = llCondiExists ? string(p.staminaRegen*2) : string(p.staminaRegen);
	draw_text(basicCol2XText,topLeftY+(line*20),"Regen: "+staminaRegenText);
}
line++;

// gold?
var sprh = sprite_get_height(spr_item_coins);
var sys = 20 / sprh;
draw_sprite_ext(spr_item_coins,1,wdCol1XPictures,topLeftY+(line*20),sys,sys,0,c_white,1);
draw_text(basicCol1XText, topLeftY+(line*20), "Gold: "  + string(getGoldCount()));
line++;
// draw_set_color(c_black);
// draw_rectangle(goldBoxTopLeftX, goldBoxTopLeftY, goldBoxBottomRightX, goldBoxBottomRightY, 0);
// draw_set_color(c_white); 
// draw_set_halign(fa_right); draw_set_valign(fa_center);
// draw_text(goldBoxBottomRightX - 5, mean(goldBoxTopLeftY, goldBoxBottomRightY), getGoldCount());

// main hand weapon
drawWeaponStats(rightHandItem,topLeftY+(line*20));
line += 6;

if !rightHandItem.isTwoHanded && leftHandItem.subType != HandItemTypes.Shield {
	drawWeaponStats(leftHandItem,topLeftY+(line*20),true);
	line+=6;
}

// defenses / poise
drawDefensesStats(topLeftY+(line*20));