/// drawWeaponStats(weapon,startingY,*isOffHand)
/// @param weapon
/// @param startingY
/// @param *isOffHand
/// draws the stats of a weapon, accounting for player variables in addition to raw item stats

var weapon = argument[0];
var startingY = argument[1];
var isOffHand = false;
if argument_count == 3 {
	isOffHand = argument[2];
}

var p = global.player;
// col1 
var line = 0;
draw_set_halign(fa_center);
draw_set_color(c_ltgray);
var hand = isOffHand ? "Off" : "Main";
draw_text(mean(topLeftX,topLeftX+width),startingY+(line*20),hand + " Hand: " + weapon.name);
draw_set_halign(fa_left);
draw_set_color(c_white);
line++;


// TODO account for item / skill bonuses for damages
var damagesStrings = getPhysicalDamageTypesString(weapon,isOffHand);
var physicalDamagesTypesString = damagesStrings[0];
var physicalDamagesString = damagesStrings[1];

// physical damages
draw_sprite(spr_item_info_damage_types,1,wdCol1XPictures,startingY+(line*20));
var stringWidth = string_width(physicalDamagesTypesString);
var scale = 1;
if stringWidth > (wdCol1Width-21) {
	scale = (wdCol1Width-21) / stringWidth;
}
draw_text_transformed(wdCol1XText,startingY+(line*20),physicalDamagesTypesString,scale,scale,0);

// col2
for (var i = 0; i < array_length_1d(global.ALL_ELEMENTS); i++) {
	var el = global.ALL_ELEMENTS[i];
	var val = ds_map_find_value(weapon.damages,el);
	var minDamage = val[0]; var maxDamage = val[1];
	if isOffHand {
		var modifier = p.offHandDamagePercent/100;
		minDamage = minDamage*modifier;
		maxDamage = maxDamage*modifier;
	}
	var sprite = noone;
	switch el {
		case MAGIC: {
			sprite = spr_item_info_damage_magic;
			break;
		}
		case FIRE: {
			sprite = spr_item_info_damage_fire;
			break;
		}
		case ICE: {
			sprite = spr_item_info_damage_ice;
			break;
		}
		case POISON: {
			sprite = spr_item_info_damage_poison;
			break;
		}
		case LIGHTNING: {
			sprite = spr_item_info_damage_lightning;
			break;
		}
	}
	draw_sprite(sprite,1,wdCol2XPictures,startingY+(line*20)+(i*20));
	if minDamage == 0 {
		draw_text(wdCol2XText,startingY+(line*20)+(i*20),"0");
	} else {
		draw_text(wdCol2XText,startingY+(line*20)+(i*20), string(minDamage) + "-" + string(maxDamage));
	}
}
line++;


draw_sprite(spr_item_info_damage_physical,1,wdCol1XPictures,startingY+(line*20));
var stringWidth = string_width(physicalDamagesString);
var scale = 1;
if stringWidth > (wdCol1Width-21) {
	scale = (wdCol1Width-21) / stringWidth;
}
draw_text_transformed(wdCol1XText,startingY+(line*20),physicalDamagesString,scale,scale,0);
line++;
draw_sprite(spr_stats_critical,1,wdCol1XPictures,startingY+(line*20));
var criticalsDamageBonus = ds_map_find_value(p.criticalsDamage,weapon.weaponType);
draw_text(wdCol1XText,startingY+(line*20),string(ds_map_find_value(p.criticalsChance,weapon.weaponType))+"%" + "/" + string(criticalsDamageBonus+100)+"%");
