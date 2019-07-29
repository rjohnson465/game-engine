/// levelUpSkill(skill*)
/// @param skill*

var selectedSkill = noone;
if argument_count > 0 {
	selectedSkill = argument[0];
}

if selectedSkill == noone {
	if !isActive exit;
	if global.player.skillPoints <= 0 {
		alert("You do not have any skill points",c_red);
		exit;
	}
	global.player.skillPoints--;
	var selectedSkill = obj_skill_selector.selectedSkill;
}

if selectedSkill.level >= selectedSkill.levelMax {
	alert(selectedSkill.name + " is at max level",c_red);
	exit;
}

selectedSkill.level++;

// normal...
if argument_count == 0 {
	selectedSkill.isLevelingUp = true;

	alert(selectedSkill.name + " is now level " + string(selectedSkill.level), c_lime);
	audio_play_sound(snd_ui_click1,1,0);
}
// if done programtically, with arg, probably for test purposes
else {
	selectedSkill.isLevelingUp = true;
	with selectedSkill {
		event_perform(ev_step, ev_step_normal);
	}
}