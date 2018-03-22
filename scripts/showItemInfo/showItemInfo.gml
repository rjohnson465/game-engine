/// showItemInfo(topLeftX,topLeftY, item)
/// @param topLeftX
/// @param topLeftY
/// @param item

// the top left X / Y values of the rectangle to show item info for
// used for displaying selected inventory item and selected equipment item side by side
// this method must be called in a Draw event

var topLeftX = argument0;
var topLeftY = argument1;
var item = argument2;

if item == undefined || !instance_exists(item) || item == noone exit;

draw_set_color(c_olive);
var descriptionHandleX2 = topLeftX+width
var descriptionHandleY2 = topLeftY+itemDescriptionHandleHeight;
draw_rectangle(topLeftX,topLeftY,descriptionHandleX2,descriptionHandleY2,false);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_center);
var s = item.name;
/*if item.totalCharges != noone {
	if item.totalCharges > 0 {
		s += " (" + string(item.charges) + "/" + string(item.totalCharges) + " charges)";
	}
}*/
draw_text(topLeftX+1,mean(descriptionHandleY2+topLeftY)/2,s);

draw_set_valign(fa_left);
// all shields and weapons share many properties, so it makes sense to lump them together when showing properties
if item.type == ItemTypes.HandItem {
					
	// auto weapon / shield description 
	var itemType = "";
	if item.subType == HandItemTypes.Shield {
		itemType = "Shield";
	} else {
		itemType = item.weaponType;
	}
					
	var autoDescription = itemType;
					
	// speed (no shield)
	if item.subType != HandItemTypes.Shield {
		autoDescription += "/" + item.weaponSpeed;
	}
	
	draw_sprite(spr_item_info,1,itemDescriptionCol1XPictures,itemDescriptionColY+25);
	draw_text(itemDescriptionCol1XText, itemDescriptionColY+25, autoDescription);
					
	// draw durability
	var durabilityString = string(item.durability) + "/" + string(item.durabilityMax);
	draw_sprite(spr_item_info_durability,1,itemDescriptionCol1XPictures,itemDescriptionColY+100);
	draw_text(itemDescriptionCol1XText,itemDescriptionColY+100,durabilityString);				
	
	// damages
	if item.subType == HandItemTypes.Melee || item.subType == HandItemTypes.Ranged {
		
		// keys -- attack number, values -- [damageType, rangeMin, rangeMax]
		var physicalDamagesMap = ds_map_create();
	
		for (var i = 0; i < array_length_1d(global.ALL_DAMAGE_TYPES); i++) {
			var damageType = global.ALL_DAMAGE_TYPES[i];
			var damageArray = ds_map_find_value(item.damages,damageType);
			var minDamage = 100000; var maxDamage = 0;
			// TODO account for slash / pierce / crush
			if damageType == CRUSH || damageType == PIERCE || damageType == SLASH {
				
				for (var j = 0; j < array_length_1d(damageArray); j+=2) {
					var num = damageArray[j];
					if num > 0 {
						ds_map_add(physicalDamagesMap,j/2,[damageType,num,damageArray[j+1]]);
					}
				}
			}
		}
		
		// order attacks
		var currentPhysicalDamageIndex = ds_map_find_first(physicalDamagesMap);
		var physicalDamageTypesArray = [];
		for (var i = 0; i < ds_map_size(physicalDamagesMap); i++) {
			var damageArray = ds_map_find_value(physicalDamagesMap,currentPhysicalDamageIndex);
			var damageType = damageArray[0];
			physicalDamageTypesArray[currentPhysicalDamageIndex] = damageType;
			currentPhysicalDamageIndex = ds_map_find_next(physicalDamagesMap,currentPhysicalDamageIndex);
		}
		var physicalDamageTypesString = ""; var physicalDamagesString = "";
		for (var i = 0; i < array_length_1d(physicalDamageTypesArray); i++) {
			var damageType = physicalDamageTypesArray[i];
			var damageArray = ds_map_find_value(physicalDamagesMap,i);
			var minDamage = damageArray[1]; var maxDamage = damageArray[2];
			var damageString = string(minDamage) + "-" + string(maxDamage);
			if i == 0 {
				physicalDamageTypesString = damageType;
				physicalDamagesString = damageString;
			}
			else {
				physicalDamageTypesString += "/" + damageType;
				physicalDamagesString += "/" + damageString;
			}
			
		}
		// draw physical damages types / values
		draw_sprite(spr_item_info_damage_types,1,itemDescriptionCol1XPictures,itemDescriptionColY+50);
		draw_text(itemDescriptionCol1XText,itemDescriptionColY+50,physicalDamageTypesString);
	
		// draw physical damages values
		draw_sprite(spr_item_info_damage_physical,1,itemDescriptionCol1XPictures,itemDescriptionColY+75);
		var stringWidth = string_width(physicalDamagesString);
		var scale = 1;
		if stringWidth > (itemDescriptionCol1Width-21) {
			scale = (itemDescriptionCol1Width-21) / stringWidth;
		}
		draw_text_transformed(itemDescriptionCol1XText,itemDescriptionColY+75,physicalDamagesString,scale,scale,0);
		
		ds_map_destroy(physicalDamagesMap); // prevent mem leak
		
		// draw magic charges (if applicable)
		if item.totalCharges > 0 {
			var magicChargesString = string(item.charges) + "/" + string(item.totalCharges);
			draw_sprite(spr_item_info_magic_charges,1,itemDescriptionCol1XPictures,itemDescriptionColY+125);
			draw_text(itemDescriptionCol1XText,itemDescriptionColY+125,magicChargesString);
		}
		
		// elemental damages (right column)
		
		for (var i = 0; i < array_length_1d(global.ALL_ELEMENTS); i++) {
			var damageType = global.ALL_ELEMENTS[i];
			var damageArray = ds_map_find_value(item.damages,damageType);
			var sprite = noone;
			switch damageType {
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
			var minDamage = 100000; var maxDamage = 0;
			minDamage = damageArray[0];
			maxDamage = damageArray[1];
			// draw damage texts in second column
			draw_sprite(sprite,1,itemDescriptionCol2XPictures,itemDescriptionColY+((i+1)*25));
			if minDamage == 0 && maxDamage == 0 {
				draw_text(itemDescriptionCol2XText,itemDescriptionColY+((i+1)*25),"0");
			} else {
				draw_text(itemDescriptionCol2XText,itemDescriptionColY+((i+1)*25),string(minDamage) + "-" + string(maxDamage));
			}
		}
		
	}
	// draw shield item info
	else if item.subType == HandItemTypes.Shield {
		
		var physBlockPercentage = ds_map_find_value(item.defenses,PHYSICAL);
		draw_sprite(spr_item_info_defense_physical,1,itemDescriptionCol1XPictures,itemDescriptionColY+50);
		draw_text(itemDescriptionCol1XText,itemDescriptionColY+50,string(physBlockPercentage) + "%");
		
		var shieldDamgeTypes = [MAGIC,FIRE,ICE,POISON,LIGHTNING];
		for (var i = 0; i < array_length_1d(shieldDamgeTypes); i++) {
			var defenseType = shieldDamgeTypes[i];
			var sprite = noone;
			switch defenseType {
				case MAGIC: {
					sprite = spr_item_info_defense_magic;
					break;
				}
				case FIRE: {
					sprite = spr_item_info_defense_fire;
					break;
				}
				case ICE: {
					sprite = spr_item_info_defense_ice;
					break;
				}
				case POISON: {
					sprite = spr_item_info_defense_poison;
					break;
				}
				case LIGHTNING: {
					sprite = spr_item_info_defense_lightning;
					break;
				}
			}
			var blockPercentage = ds_map_find_value(item.defenses,defenseType);
			// draw damage texts in second column
			draw_sprite(sprite,1,itemDescriptionCol2XPictures,itemDescriptionColY+((i+1)*25));
			draw_text(itemDescriptionCol2XText,itemDescriptionColY+((i+1)*25),string(blockPercentage)+"%");
		}
	}
		
}