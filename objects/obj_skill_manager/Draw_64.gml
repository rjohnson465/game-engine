if !ui.isShowingMenus || ui.currentMenu != SKILLS exit;

drawSkillSlot(healthMaxX,healthMaxY,Skills.HealthMax);
drawSkillSlot(staminaMaxX,staminaMaxY,Skills.StaminaMax);
drawSkillSlot(bladeMasteryX,bladeMasteryY,Skills.BladeMastery);

// skill description
//showSkillInfo(skillSelector.selectedSkill);
if skillSelector != noone {
	showSkillInfo(skillSelector.selectedSkill);
}