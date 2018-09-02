/// levelUpSkill()
if !isActive exit;
if global.player.skillPoints <= 0 {
	alert("You do not have any skill points",c_red);
	exit;
}

var selectedSkill = obj_skill_selector.selectedSkill;

if selectedSkill.level >= selectedSkill.levelMax {
	alert(selectedSkill.name + " is at max level",c_red);
	exit;
}

selectedSkill.level++;
selectedSkill.isLevelingUp = true;
global.player.skillPoints--;
alert(selectedSkill.name + " is now level " + string(selectedSkill.level), c_lime);
audio_play_sound(snd_ui_click1,1,0);