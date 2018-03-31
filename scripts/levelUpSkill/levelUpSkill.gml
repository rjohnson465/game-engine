/// levelUpSkill()

if global.player.skillPoints <= 0 {
	alert("You do not have any skill points",c_red);
	exit;
}

var selectedSkill = obj_skill_selector.selectedSkill;

selectedSkill.level++;
selectedSkill.isLevelingUp = true;
