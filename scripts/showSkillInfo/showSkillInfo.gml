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

draw_text(skillDescriptionCol1X,descriptionHandleY2,"Current Level: " + string(skill.level));
draw_text(skillDescriptionCol2X,descriptionHandleY2,"Next Level: " + string(skill.level+1));

var currentBonus = ds_map_find_first(skill.bonusesMap); // enum value (ModifiableProperty)

for (var i = 0; i < ds_map_size(skill.bonusesMap); i++) {
	var currentBonusString = getSkillPropertyString(currentBonus); // actaul string
	// TODO -- redo how the HP / Stamina bonus is shown
	if skill.object_index == obj_skill_hpmax || skill.object_index == obj_skill_staminamax {
		var bonus =	ds_map_find_value(skill.bonusesMap,currentBonus)
		var bonusNext = ds_map_find_value(skill.nextLevelBonusesMap,currentBonus);
		var baseStat = skill.object_index == obj_skill_hpmax ? global.player.maxHp : global.player.maxStamina;
		var s = skill.object_index == obj_skill_hpmax ? "Max HP: " : "Max Stamina: ";
		draw_text(skillDescriptionCol1X,descriptionHandleY2+(i+1)*25,s + string(baseStat+bonus));
		draw_text(skillDescriptionCol2X,descriptionHandleY2+(i+1)*25,s + string(baseStat+bonusNext));
	} else {
		var currentBonusVal = ds_map_find_value(skill.bonusesMap,currentBonus);
		var bonusString = "+ " + string(currentBonusVal) + currentBonusString;
		draw_text(skillDescriptionCol1X,descriptionHandleY2+((i+1)*25),bonusString);
		
		var nextBonusVal = ds_map_find_value(skill.nextLevelBonusesMap,currentBonus);
		var nextLevelBonusString = "+ " + string(nextBonusVal) + currentBonusString;
		draw_text(skillDescriptionCol2X,descriptionHandleY2+((i+1)*25),nextLevelBonusString);
	}
	currentBonus = ds_map_find_next(skill.bonusesMap,currentBonus);
}

