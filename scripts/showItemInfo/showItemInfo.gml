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
if item.type == ItemTypes.HandItem {
	if item.subType == HandItemTypes.Melee {
		if item.weaponType == UNARMED exit; // do not display info for Unarmed
	}
}

draw_set_color(C_HANDLES);
var descriptionHandleX2 = topLeftX+width
var descriptionHandleY2 = topLeftY+itemDescriptionHandleHeight;
draw_rectangle(topLeftX,topLeftY,descriptionHandleX2,descriptionHandleY2,false);

// draw item name in color according to item rarity
draw_set_color(ds_map_find_value(global.itemRarityColors, item.rarity));

draw_set_halign(fa_center);
draw_set_valign(fa_center);
var s = item.name;
var ns = 1; // name scale
if string_width(s) > width-2 {
	ns = (width-2)/string_width(s);
}
draw_text_transformed(mean(topLeftX,topLeftX+width),mean(descriptionHandleY2+topLeftY)/2,s,ns,1,0);

draw_set_valign(fa_left);
draw_set_halign(fa_left);
draw_set_color(c_white);
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
	
	var adsw = string_width(autoDescription);
	draw_set_color(c_white);
	draw_sprite(spr_item_info,1,itemDescriptionCol1XPictures,itemDescriptionColY+5);
	if !global.ui.isShowingExplanations {
		draw_text(itemDescriptionCol1XText, itemDescriptionColY+5, autoDescription);
	} else {
		if item.subType != HandItemTypes.Shield {
			draw_text(itemDescriptionCol1XText, itemDescriptionColY+5, "Type/1H or 2H/Speed");
			adsw = string_width("Type/1H or 2H/Speed");
		} else {
			draw_text(itemDescriptionCol1XText, itemDescriptionColY+5, "Type");
		}
	}
	
	// draw mastery requirement
	if !object_is_ancestor(item.object_index, obj_shield_parent) && item.object_index != obj_unarmed_parent && item.requiredMastery != 0 {
		draw_sprite(spr_item_info_required_mastery,1,itemDescriptionCol1XText+adsw+5, itemDescriptionColY+5);
		var sprw = sprite_get_width(spr_item_info_required_mastery);
		
		if !global.ui.isShowingExplanations {
			var skill = noone;
			skill = getSkillForItem(item);
		
			if skill.level < item.requiredMastery {
				draw_set_color(c_red);
			} else {
				draw_set_color(c_white);
			}
			var s = skill.name + " " + string(item.requiredMastery);
			draw_text(itemDescriptionCol1XText+adsw+sprw+10, itemDescriptionColY+5,s);
		} else {
			draw_set_color(c_white);
			draw_text(itemDescriptionCol1XText+adsw+sprw+10, itemDescriptionColY+5,"Skill prereq.");
		}
	}
	
	// draw durability
	if !item.isRanged {
		var durabilityString = string(item.durability) + "/" + string(item.durabilityMax);
		draw_sprite(spr_item_info_durability,1,itemDescriptionCol1XPictures,itemDescriptionColY+80);
		if !global.ui.isShowingExplanations {
			var durabilityBuff = ds_map_find_value(item.itemPropertyModifiers, WeaponProperties.DurabilityAmmoBonus);
			draw_set_color(getPropertyColorForBuffAmount(durabilityBuff));
			if item.durability == 0 draw_set_color(c_red);
			draw_text(itemDescriptionCol1XText,itemDescriptionColY+80,durabilityString);
		} else {
			draw_set_color(c_white);
			draw_text(itemDescriptionCol1XText,itemDescriptionColY+80,"Durability / Max durability");
		}
	}
	
	// draw ammo
	if item.isRanged {
		var ammoString = string(item.ammo) + "/" + string(item.ammoMax);
		draw_sprite(spr_item_info_ammo,1,itemDescriptionCol1XPictures,itemDescriptionColY+80);
		if !global.ui.isShowingExplanations {
			var ammoBuff = ds_map_find_value(item.itemPropertyModifiers, WeaponProperties.DurabilityAmmoBonus);
			draw_set_color(getPropertyColorForBuffAmount(ammoBuff));
			draw_text(itemDescriptionCol1XText,itemDescriptionColY+80,ammoString);
		} else {
			draw_set_color(c_white);
			draw_text(itemDescriptionCol1XText,itemDescriptionColY+80,"Ammo / Max ammo");
		}
	}
	
	// damages
	if item.subType == HandItemTypes.Melee || item.subType == HandItemTypes.Ranged {
		
		var damagesStrings = getPhysicalDamageTypesString(item);
		var physicalDamageTypesString = damagesStrings[0];
		var physicalDamagesString = damagesStrings[1];
		
		// draw physical damages types / values
		draw_sprite(spr_item_info_damage_types,1,itemDescriptionCol1XPictures,itemDescriptionColY+30);
		if !global.ui.isShowingExplanations {
			draw_set_color(c_white);
			draw_text(itemDescriptionCol1XText,itemDescriptionColY+30,physicalDamageTypesString);
		} else {
			draw_set_color(c_white);
			draw_text(itemDescriptionCol1XText,itemDescriptionColY+30,"Phys. attacks type(s)");
		}
	
		// draw physical damages values
		draw_sprite(spr_item_info_damage_physical,1,itemDescriptionCol1XPictures,itemDescriptionColY+55);
		var stringWidth = string_width(physicalDamagesString);
		var scale = 1;
		if stringWidth > (itemDescriptionCol1Width-21) {
			scale = (itemDescriptionCol1Width-21) / stringWidth;
		}
		if !global.ui.isShowingExplanations {
			var physDamageBuff = ds_map_find_value(item.itemPropertyModifiers, WeaponProperties.PhysicalDamageBonus);
			draw_set_color(getPropertyColorForBuffAmount(physDamageBuff));
			draw_text_transformed(itemDescriptionCol1XText,itemDescriptionColY+55,physicalDamagesString,scale,scale,0);
		} else {
			draw_set_color(c_white);
			draw_text_transformed(itemDescriptionCol1XText,itemDescriptionColY+55,"Phys. attacks damage",scale,scale,0);
		}
		
		// draw magic charges (if applicable)
		if item.chargesMax > 0 {
			var magicChargesString = string(item.charges) + "/" + string(item.chargesMax);
			draw_sprite(spr_item_info_magic_charges,1,itemDescriptionCol1XPictures,itemDescriptionColY+105);
			if !global.ui.isShowingExplanations {
				var chargesBuff = ds_map_find_value(item.itemPropertyModifiers, WeaponProperties.ChargesBonus);
				draw_set_color(getPropertyColorForBuffAmount(chargesBuff));
				draw_text(itemDescriptionCol1XText,itemDescriptionColY+105,magicChargesString);
			} else {
				draw_set_color(c_white);
				draw_text(itemDescriptionCol1XText,itemDescriptionColY+105,"Charges / Max charges");
			}
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
			if !global.ui.isShowingExplanations {
				if minDamage == 0 && maxDamage == 0 {
					draw_set_color(c_white);
					draw_text(itemDescriptionCol2XText,itemDescriptionColY+((i+1)*25),"0");
				} else {
					var elDamageBuff = ds_map_find_value(item.itemPropertyModifiers, WeaponProperties.ElementalDamageBonus);
					if elDamageBuff != undefined {
						var el = elDamageBuff[0];
						if el == damageType {
							draw_set_color(getPropertyColorForBuffAmount(elDamageBuff[1]));
						} else {
							draw_set_color(c_white);
						}
					} else {
						draw_set_color(c_white);
					}
					draw_text(itemDescriptionCol2XText,itemDescriptionColY+((i+1)*25),string(minDamage) + "-" + string(maxDamage));
				}
			} else {
				draw_set_color(c_white);
				draw_text(itemDescriptionCol2XText,itemDescriptionColY+((i+1)*25),damageType);
			}
			
		}
		
	}
	// draw shield item info
	else if item.subType == HandItemTypes.Shield {
		
		draw_set_color(c_white);
		
		var physBlockPercentage = ds_map_find_value(item.defenses,PHYSICAL);
		if physBlockPercentage > 100 physBlockPercentage = 100;
		draw_sprite(spr_item_info_defense_physical,1,itemDescriptionCol1XPictures,itemDescriptionColY+50);
		if !global.ui.isShowingExplanations {
			var physBuff = ds_map_find_value(item.itemPropertyModifiers, ShieldProperties.PhysicalBlockBonus);
			draw_set_color(getPropertyColorForBuffAmount(physBuff));
			draw_text(itemDescriptionCol1XText,itemDescriptionColY+50,string(physBlockPercentage) + "%");
		} else {
			draw_set_color(c_white);
			draw_text(itemDescriptionCol1XText,itemDescriptionColY+50,"Phys. absorption");
		}
		
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
			if blockPercentage > 100 blockPercentage = 100;
			if blockPercentage < 0 blockPercentage = 0;
			// draw damage texts in second column
			draw_sprite(sprite,1,itemDescriptionCol2XPictures,itemDescriptionColY+((i+1)*25));
			if !global.ui.isShowingExplanations {
				var elBuff = ds_map_find_value(item.itemPropertyModifiers, ShieldProperties.ElementalBlockBonus);
				if elBuff != undefined {
					var el = elBuff[0];
					if el == defenseType {
						draw_set_color(getPropertyColorForBuffAmount(elBuff[1]));
					} else {
						draw_set_color(c_white);
					}
				} else {
					draw_set_color(c_white);
				}
				draw_text(itemDescriptionCol2XText,itemDescriptionColY+((i+1)*25),string(blockPercentage)+"%");
			} else {
				draw_set_color(c_white);
				draw_text(itemDescriptionCol2XText,itemDescriptionColY+((i+1)*25),defenseType);
			}
		}
	}
}
// Misc items, show item description
else if item.type == ItemTypes.Other {
	if object_is_ancestor(item.object_index,obj_gem_parent) {
		var el = noone;
		var damageSprite = noone; var defenseSprite = noone;
		switch item.subType {
			case GemTypes.Aquamarine: {
				el = ICE; damageSprite = spr_item_info_damage_ice; defenseSprite = spr_item_info_defense_ice; break;
			}
			case GemTypes.Lapis: {
				el = MAGIC; damageSprite = spr_item_info_damage_magic; defenseSprite = spr_item_info_defense_magic; break;
			}
			case GemTypes.Emerald: {
				el = POISON; damageSprite = spr_item_info_damage_poison; defenseSprite = spr_item_info_defense_poison; break;
			}
			case GemTypes.Topaz: {
				el = LIGHTNING; damageSprite = spr_item_info_damage_lightning; defenseSprite = spr_item_info_defense_lightning; break;
			}
			case GemTypes.Hematite: {
				el = PHYSICAL; damageSprite = spr_item_info_damage_physical; defenseSprite = spr_item_info_defense_physical; break;
			}
			case GemTypes.Ruby: {
				el = FIRE; damageSprite = spr_item_info_damage_fire; defenseSprite = spr_item_info_defense_fire; break;
			}
		}
		
		var minValue = 0; var maxValue = 0; var shieldValue = 0; var headValue = 0;
		switch item.condition {
			case CRACKED: {
				minValue = 2; maxValue = 4; shieldValue = 5; headValue = 3; break;
			}
		}
		
		draw_text(topLeftX+5,topLeftY+itemDescriptionHandleHeight+5,"Insert into socketed item at fountain");
		
		draw_sprite(damageSprite,1,itemDescriptionCol1XPictures,topLeftY+itemDescriptionHandleHeight+30);
		draw_text(itemDescriptionCol1XText,topLeftY+itemDescriptionHandleHeight+30,"Weapons: +" + string(minValue) + "-" + string(maxValue) + " " + el + " damage");
		
		draw_sprite(defenseSprite,1,itemDescriptionCol1XPictures,topLeftY+itemDescriptionHandleHeight+55);
		draw_text(itemDescriptionCol1XText,topLeftY+itemDescriptionHandleHeight+55,"Shields: +" + string(shieldValue) + "% " + el + " absorption");
		var defenseOrResist = el == PHYSICAL ? " defenses" : " resistance";
		var percentOrNah = el == PHYSICAL ? " all" : "%";
		draw_sprite(defenseSprite,1,itemDescriptionCol1XPictures,topLeftY+itemDescriptionHandleHeight+80);
		draw_text(itemDescriptionCol1XText,topLeftY+itemDescriptionHandleHeight+80,"Hats: +" + string(headValue) + percentOrNah + " " + el + defenseOrResist);
	} else {
		var sh = string_height(item.description);
		draw_text_ext(topLeftX+5,topLeftY+itemDescriptionHandleHeight+5,item.description,sh,width-5);
		if item.object_index == obj_item_coins {
			draw_text(itemDescriptionTopLeftX,itemDescriptionBottomRightY-sh,"Quantity: " + string(item.count));
		}
	}
}
// Ring items, show all properties
else if item.type == ItemTypes.Ring {
	var ringProps = item.itemProperties;
	var currentProperty = ds_map_find_first(ringProps);
	var line = 0;
	for(var i = 0; i < ds_map_size(ringProps); i++) {
		
		var val = ds_map_find_value(ringProps,currentProperty);
		var macro = noone;
		// if array, its in the form [macro,val]
		if is_array(val) {
			macro = val[0];
			val = val[1];
		}
		var s = getItemPropertyString(currentProperty,macro);
		
		var sgn = val > 0 ? "+" : "-";
		var finalString = sgn + string(val) + s;
		var scale = 1;
		var operatingWidth = itemDescriptionBottomRightX-itemDescriptionTopLeftX-21;
		if string_width(finalString) > operatingWidth {
			scale = operatingWidth / string_width(finalString);
		}
		draw_text_transformed(itemDescriptionCol1XText,itemDescriptionColY+(line*25)+5,finalString,scale,scale,0);
		line++;
		
		currentProperty = ds_map_find_next(ringProps,currentProperty);
	}
}
// Head items, show defenses
else if item.type == ItemTypes.Head {
	
	// slash
	draw_sprite(spr_item_info_defense_slash,1,itemDescriptionCol1XPictures,itemDescriptionColY+25);
	if !global.ui.isShowingExplanations {
		var slashBonus = ds_map_find_value(item.itemPropertyModifiers, HatProperties.SlashDefenseBonus);
		draw_set_color(getPropertyColorForBuffAmount(slashBonus));
		draw_text(itemDescriptionCol1XText,itemDescriptionColY+25,"vs. Slash: "+string(ds_map_find_value(item.defenses,SLASH)));
	} else {
		draw_set_color(c_white);
		draw_text(itemDescriptionCol1XText,itemDescriptionColY+25,"Item Slash Defense");
	}
	// crush 
	draw_sprite(spr_item_info_defense_crush,1,itemDescriptionCol1XPictures,itemDescriptionColY+50);
	if !global.ui.isShowingExplanations {
		var crushBonus = ds_map_find_value(item.itemPropertyModifiers, HatProperties.CrushDefenseBonus);
		draw_set_color(getPropertyColorForBuffAmount(crushBonus));
		draw_text(itemDescriptionCol1XText,itemDescriptionColY+50,"vs. Crush: " + string(ds_map_find_value(item.defenses,CRUSH)));
	} else {
		draw_set_color(c_white);
		draw_text(itemDescriptionCol1XText,itemDescriptionColY+50,"Item Crush Defense");
	}
	// pierce
	draw_sprite(spr_item_info_defense_pierce,1,itemDescriptionCol1XPictures,itemDescriptionColY+75);
	if !global.ui.isShowingExplanations {
		var pierceBonus = ds_map_find_value(item.itemPropertyModifiers, HatProperties.PierceDefenseBonus);
		draw_set_color(getPropertyColorForBuffAmount(pierceBonus));
		draw_text(itemDescriptionCol1XText,itemDescriptionColY+75,"vs. Pierce: "+ string(ds_map_find_value(item.defenses,PIERCE)));
	} else {
		draw_set_color(c_white);
		draw_text(itemDescriptionCol1XText,itemDescriptionColY+75,"Item Pierce Defense");
	}
	/*// durability?
	draw_sprite(spr_item_info_durability,1,itemDescriptionCol1XPictures,itemDescriptionColY+100);
	if !global.ui.isShowingExplanations {
		draw_text(itemDescriptionCol1XText,itemDescriptionColY+100,string(item.durability)+"/"+string(item.durabilityMax));
	} else draw_text(itemDescriptionCol1XText,itemDescriptionColY+100,"Durability / max durability");*/
	
	for (var i = 0; i < array_length_1d(global.ALL_ELEMENTS); i++) {
		var el = global.ALL_ELEMENTS[i];
		var val = ds_map_find_value(item.defenses,el);
		var sprite = noone;
		switch el {
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
		draw_sprite(sprite,1,itemDescriptionCol2XPictures,itemDescriptionColY+((i+1)*25));
		if !global.ui.isShowingExplanations {
			var elBuff = ds_map_find_value(item.itemPropertyModifiers, HatProperties.ElementalDefenseBonus);
			if elBuff != undefined {
				var ele = elBuff[0];
				if ele == el {
					draw_set_color(getPropertyColorForBuffAmount(elBuff[1]));
				} else {
					draw_set_color(c_white);
				}
			} else {
				draw_set_color(c_white);
			}
			draw_text(itemDescriptionCol2XText,itemDescriptionColY+((i+1)*25),string(val)+"%");
		} else {
			draw_set_color(c_white);
			draw_text(itemDescriptionCol2XText,itemDescriptionColY+((i+1)*25),el);
		}
	}
}

if item.isSellable {
	draw_set_color(c_white);
	var w = sprite_get_width(spr_item_info_defense_crush);
	var xs = w/sprite_get_width(spr_item_coins);
	draw_sprite_ext(spr_item_coins,1,itemDescriptionCol1XPictures,itemDescriptionColY+130,xs,xs,0,c_white,1);
	if !global.ui.isShowingExplanations {
		draw_text(itemDescriptionCol1XText,itemDescriptionColY+130,string(item.value));
	} else {
		draw_text(itemDescriptionCol1XText,itemDescriptionColY+130,"Value");
	}
}