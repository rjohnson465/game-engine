if !ui.isShowingMenus || ui.currentMenu != INVENTORY exit;

var p = global.player;
var leftHandItem = ds_map_find_value(p.equippedLimbItems,"l");
var rightHandItem = ds_map_find_value(p.equippedLimbItems,"r");

var line = 0;
draw_set_valign(fa_top); draw_set_halign(fa_left);
//draw_set_alpha(1);
draw_set_color(c_white);

// level / xp
draw_text(basicCol1XText,topLeftY,"Level: " + string(p.level));
draw_text(basicCol2XText,topLeftY,string(p.xp) + "/" + string(p.xpToNextLevel));
line++;

// hp
draw_text(basicCol1XText,topLeftY+(line*20),"HP: " + string(round(p.hp)) + "/" + string(p.maxHp));
draw_text(basicCol2XText,topLeftY+(line*20),p.hpRegen);
line++;

// stamina
draw_text(basicCol1XText,topLeftY+(line*20),"Stamina: " + string(round(p.stamina)) + "/" + string(p.maxStamina));
draw_text(basicCol2XText,topLeftY+(line*20),p.staminaRegen);
line++;

// main hand weapon
drawWeaponStats(leftHandItem,topLeftY+(line*20));
line += 6;

if !leftHandItem.isTwoHanded && rightHandItem.subType != HandItemTypes.Shield {
	drawWeaponStats(rightHandItem,topLeftY+(line*20),true);
}




// col2
/*
// offhand
if !leftHandItem.isTwoHanded || rightHandItem.subType != HandItemTypes.Shield {
	var damagesStrings = getPhysicalDamageTypesString(rightHandItem,true);
	var physicalDamagesTypesString = damagesStrings[0];
	var physicalDamagesString = damagesStrings[1];
	draw_text(topLeftX,topLeftY+(line*20),"Main hand: " + rightHandItem.name + "(" + physicalDamagesTypesString + ")");
	line++;
	draw_text(topLeftX,topLeftY+(line*20),"Phys:" + physicalDamagesString);
	line++;
	draw_text(topLeftX,topLeftY+(line*20),"Critical chance: " + string(ds_map_find_value(p.criticalsChance,rightHandItem.weaponType))+"%");
}

// defenses / poise
