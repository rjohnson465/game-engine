if !ui.isShowingMenus || ui.currentMenu != INVENTORY exit;

var p = global.player;
var leftHandItem = ds_map_find_value(p.equippedLimbItems,"l");
var rightHandItem = ds_map_find_value(p.equippedLimbItems,"r");

var line = 0;
draw_set_valign(fa_top); draw_set_halign(fa_left);
//draw_set_alpha(1);
draw_set_color(c_white);

// level / xp
draw_sprite(spr_stats_level,1,wdCol1XPictures,topLeftY+(line*20));
draw_text(basicCol1XText,topLeftY,"Level: " + string(p.level));
// xp
draw_sprite(spr_stats_xp,1,basicCol2XPictures,topLeftY+(line*20));
draw_text(basicCol2XText,topLeftY,string(p.xp) + "/" + string(p.xpToNextLevel));
line++;

// hp
draw_sprite(spr_stats_hp,1,basicCol1XPictures,topLeftY+(line*20));
draw_text(basicCol1XText,topLeftY+(line*20),string(round(p.hp)) + "/" + string(p.maxHp));
draw_sprite(spr_stats_hp_regen,1,basicCol2XPictures,topLeftY+(line*20));
draw_text(basicCol2XText,topLeftY+(line*20),string(p.hpRegen) + "/second");
line++;

// stamina
draw_sprite(spr_stats_stamina,1,wdCol1XPictures,topLeftY+(line*20));
draw_text(basicCol1XText,topLeftY+(line*20),string(round(p.stamina)) + "/" + string(p.maxStamina));
draw_sprite(spr_stats_stamina_regen,1,basicCol2XPictures,topLeftY+(line*20));
draw_text(basicCol2XText,topLeftY+(line*20),string(p.staminaRegen)+"/second");
line++;

// main hand weapon
drawWeaponStats(leftHandItem,topLeftY+(line*20));
line += 6;

if !leftHandItem.isTwoHanded && rightHandItem.subType != HandItemTypes.Shield {
	drawWeaponStats(rightHandItem,topLeftY+(line*20),true);
	line+=6;
}

// defenses / poise
drawDefensesStats(topLeftY+(line*20));