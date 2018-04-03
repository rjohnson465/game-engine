/// showSkillInfo(skill)
/// @param skill

// the top left X / Y values of the rectangle to show item info for
// this method must be called in a Draw event

//var topLeftX = argument0;
//var topLeftY = argument1;
var skill = argument[0];

var topLeftX = skillDescriptionTopLeftX;
var topLeftY = skillDescriptionTopLeftY;

draw_set_color(c_olive);
var descriptionHandleX2 = topLeftX+width
var descriptionHandleY2 = topLeftY+skillDescriptionHandleHeight;
draw_rectangle(topLeftX,topLeftY,descriptionHandleX2,descriptionHandleY2,false);
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_center);
var s = skill.name;

draw_text(mean(topLeftX,topLeftX+width),mean(descriptionHandleY2+topLeftY)/2,s);

draw_set_valign(fa_top);
draw_set_halign(fa_left);
draw_text_ext(topLeftX,descriptionHandleY2,skill.description,20,width);
var descriptionHeight = string_height_ext(skill.description,20,width);
descriptionHandleY2+= descriptionHeight;

draw_text(skillDescriptionCol1X,descriptionHandleY2,"Current Level: " + string(skill.level) + "/" + string(skill.levelMax));
if skill.level != skill.levelMax {
	draw_text(skillDescriptionCol2X,descriptionHandleY2,"Next Level: " + string(skill.level+1) + "/" + string(skill.levelMax));
}

var currentBonus = ds_map_find_first(skill.bonusesMap); // enum value (ModifiableProperty)

for (var i = 0; i < ds_map_size(skill.bonusesMap); i++) {
	var currentBonusString = getSkillPropertyString(currentBonus); // actual string
	// TODO -- redo how the HP / Stamina bonus is shown
	if skill.object_index == obj_skill_hpmax || skill.object_index == obj_skill_staminamax {
		var bonus =	ds_map_find_value(skill.bonusesMap,currentBonus)
		var bonusNext = ds_map_find_value(skill.nextLevelBonusesMap,currentBonus);
		var baseStat = skill.object_index == obj_skill_hpmax ? global.player.maxHp : global.player.maxStamina;
		var s = skill.object_index == obj_skill_hpmax ? "Additonal HP: " : "Additonal Stamina: ";
		draw_text(skillDescriptionCol1X,descriptionHandleY2+(i+1)*25,s + string(bonus));
		draw_text(skillDescriptionCol2X,descriptionHandleY2+(i+1)*25,s + string(bonusNext));
	}
	// SPELLS - Magic Missile
	else if object_is_ancestor(skill.object_index,obj_spell_parent) {
		continue; // handle this outside loop
	}
	else {
		var currentBonusVal = ds_map_find_value(skill.bonusesMap,currentBonus);
		var includePlus = skill.object_index == obj_skill_offhanddamage ? "" : "+ ";
		//var includePlus = "+ ";
		var bonusString = includePlus + string(currentBonusVal) + currentBonusString;
		draw_text(skillDescriptionCol1X,descriptionHandleY2+((i+1)*25),bonusString);
		
		if skill.level != skill.levelMax {
			var nextBonusVal = ds_map_find_value(skill.nextLevelBonusesMap,currentBonus);
			var nextLevelBonusString = includePlus + string(nextBonusVal) + currentBonusString;
			draw_text(skillDescriptionCol2X,descriptionHandleY2+((i+1)*25),nextLevelBonusString);
		}
	}
	currentBonus = ds_map_find_next(skill.bonusesMap,currentBonus);
}

if object_is_ancestor(skill.object_index,obj_spell_parent) {
	switch skill.object_index {
		case obj_spell_magicmissile: {
			// number of projectiles
			draw_text(skillDescriptionCol1X,descriptionHandleY2+25,"Missiles: " + string(skill.numberOfProjectiles));
			if skill.level != skill.levelMax {
				var nextLevelNumberOfProjectiles = ds_map_find_value(skill.numberOfProjectilesByLevel,skill.level+1);
				draw_text(skillDescriptionCol2X,descriptionHandleY2+25, "Missiles: " + string(nextLevelNumberOfProjectiles));
			}
			// damage per projectile
			draw_text(skillDescriptionCol1X,descriptionHandleY2+50,"Damage / missile: " + string(skill.minDamage) + "-" + string(skill.maxDamage));
			if skill.level != skill.levelMax {
				var nextLevelRange = ds_map_find_value(skill.damageRangesByLevel,skill.level+1);
				draw_text(skillDescriptionCol2X,descriptionHandleY2+50, "Damage / missile: " + string(nextLevelRange[0]) + "-" + string(nextLevelRange[1]));
			}
			// maximum charge cost
			draw_text(skillDescriptionCol1X,descriptionHandleY2+75,"Max magic charges cost: " + string(skill.maxChargeCost));
			if skill.level != skill.levelMax {
				var nextLevelMaxCharge = ds_map_find_value(skill.maxChargeCostByLevel,skill.level+1);
				draw_text(skillDescriptionCol2X,descriptionHandleY2+75, "Max magic charges cost: " + string(nextLevelMaxCharge));
			}
			break;
		}
		case obj_spell_projectile: {
			// damage per projectile
			draw_text(skillDescriptionCol1X,descriptionHandleY2+25,"Blast damage: " + string(skill.minDamage) + "-" + string(skill.maxDamage));
			if skill.level != skill.levelMax {
				var nextLevelRange = ds_map_find_value(skill.damageRangesByLevel,skill.level+1);
				draw_text(skillDescriptionCol2X,descriptionHandleY2+25, "Blast damage: " + string(nextLevelRange[0]) + "-" + string(nextLevelRange[1]));
			}
			// maximum charge cost
			draw_text(skillDescriptionCol1X,descriptionHandleY2+50,"Max magic charges cost: " + string(skill.maxChargeCost));
			if skill.level != skill.levelMax {
				var nextLevelMaxCharge = ds_map_find_value(skill.maxChargeCostByLevel,skill.level+1);
				draw_text(skillDescriptionCol2X,descriptionHandleY2+50, "Max magic charges cost: " + string(nextLevelMaxCharge));
			}
			break;
		}
		case obj_spell_aoe: {
			// number of projectiles
			draw_text(skillDescriptionCol1X,descriptionHandleY2+25,"Projectiles: " + string(skill.numberOfProjectiles));
			if skill.level != skill.levelMax {
				var nextLevelNumberOfProjectiles = ds_map_find_value(skill.numberOfProjectilesByLevel,skill.level+1);
				draw_text(skillDescriptionCol2X,descriptionHandleY2+25, "Projectiles: " + string(nextLevelNumberOfProjectiles));
			}
			// damage per projectile
			draw_text(skillDescriptionCol1X,descriptionHandleY2+50,"Damage / projectile: " + string(skill.minDamage) + "-" + string(skill.maxDamage));
			if skill.level != skill.levelMax {
				var nextLevelRange = ds_map_find_value(skill.damageRangesByLevel,skill.level+1);
				draw_text(skillDescriptionCol2X,descriptionHandleY2+50, "Damage / projectile: " + string(nextLevelRange[0]) + "-" + string(nextLevelRange[1]));
			}
			// maximum charge cost
			draw_text(skillDescriptionCol1X,descriptionHandleY2+75,"Max magic charges cost: " + string(skill.maxChargeCost));
			if skill.level != skill.levelMax {
				var nextLevelMaxCharge = ds_map_find_value(skill.maxChargeCostByLevel,skill.level+1);
				draw_text(skillDescriptionCol2X,descriptionHandleY2+75, "Max magic charges cost: " + string(nextLevelMaxCharge));
			}
			break;
		}
	}
}

