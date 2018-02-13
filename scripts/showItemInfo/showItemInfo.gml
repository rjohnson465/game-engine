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
if item.totalCharges != noone {
	if item.totalCharges > 0 {
		s += " (" + string(item.charges) + "/" + string(item.totalCharges) + " charges)";
	}
}
draw_text(topLeftX+1,mean(descriptionHandleY2+topLeftY)/2,s);
				
// all shields and weapons share many properties, so it makes sense to lump them together when showing properties
if item.type == ItemTypes.HandItem {
					
	// auto weapon / shield description 
	var numHands = item.isTwoHanded ? "2H" : "1H";
	var itemType = "";
	if item.totalCharges != 0 {
		itemType = "Magical Implement";
	} else if item.subType == HandItemTypes.Ranged {
		itemType = "Ranged Weapon";
	} else if item.subType == HandItemTypes.Shield {
		itemType = "Shield";
	} else {
		itemType = "Melee Weapon";
	}
					
	var autoDescription = numHands + " " + itemType;
	draw_text(itemDescriptionCol1X, itemDescriptionColY+20, autoDescription);
					
	// speed (no shield)
	if item.subType != HandItemTypes.Shield {
		var s = item.weaponSpeed + " Attack Speed";
		draw_text(itemDescriptionCol1X, itemDescriptionColY+40, s);
	}
					
	// weight
	var s = "Weight: " + string(item.weight);
	draw_text(itemDescriptionCol1X,itemDescriptionColY+60,s);
	// value 
	var s = "Value: " + string(item.value);
	draw_text(itemDescriptionCol1X,itemDescriptionColY+80,s);
					
	// damages
	if item.subType == HandItemTypes.Melee || item.subType == HandItemTypes.Ranged {
		for (var i = 0; i < array_length_1d(global.ALL_DAMAGE_TYPES); i++) {
			var damageType = global.ALL_DAMAGE_TYPES[i];
			var damageArray = ds_map_find_value(item.damages,damageType);
			var minDamage = 100000; var maxDamage = 0;
			if damageType == PHYSICAL {
				for (var j = 0; j < array_length_1d(damageArray); j++) {
					var num = damageArray[j];
					if num < minDamage {
						minDamage = num;
					} 
					if num > maxDamage {
						maxDamage = num;
					}
				}
			}
			else {
				minDamage = damageArray[0];
				maxDamage = damageArray[1];
			}
			// draw damage texts in second column
			if minDamage == 0 && maxDamage == 0 {
				draw_text(itemDescriptionCol2X,itemDescriptionColY+((i+1)*20),damageType + ": 0");
			} else {
				draw_text(itemDescriptionCol2X,itemDescriptionColY+((i+1)*20),damageType + ": " + string(minDamage) + "-" + string(maxDamage));
			}
		}
	} else if item.subType == HandItemTypes.Shield {
		for (var i = 0; i < array_length_1d(global.ALL_DAMAGE_TYPES); i++) {
			var defenseType = global.ALL_DAMAGE_TYPES[i];
			var blockPercentage = ds_map_find_value(item.defenses,defenseType);
			// draw damage texts in second column
			draw_text(itemDescriptionCol2X,itemDescriptionColY+(i*20),defenseType + ": " + string(blockPercentage));
		}
	}
		
}