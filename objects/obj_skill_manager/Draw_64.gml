if !ui.isShowingMenus || ui.currentMenu != SKILLS exit;
var p = global.player;

// General skills
drawSkillSlot(healthMaxX,healthMaxY,Skills.HealthMax);
drawSkillSlot(staminaMaxX,staminaMaxY,Skills.StaminaMax);
drawSkillSlot(offHandMasteryX,offHandMasteryY,Skills.OffHandDamage);

// Melee skills
drawSkillSlot(bladeMasteryX,bladeMasteryY,Skills.BladeMastery);
drawSkillSlot(axeMasteryX,axeMasteryY,Skills.AxeMastery);
drawSkillSlot(clubMasteryX,clubMasteryY,Skills.ClubMastery);
drawSkillSlot(pointyMasteryX,pointyMasteryY,Skills.PointyMastery);

// Ranged Skills
drawSkillSlot(bowMasteryX,bowMasteryY,Skills.BowMastery);
drawSkillSlot(gunMasteryX,gunMasteryY,Skills.GunMastery);
drawSkillSlot(assassinMasteryX,assassinMasteryY,Skills.AssassinMastery);

// Magic skills
drawSkillSlot(blastMasteryX,blastMasteryY,Skills.BlastMastery);
drawSkillSlot(explosionMasteryX,explosionMasteryY,Skills.ExplosionMastery);
drawSkillSlot(magicMissileMasteryX,magicMissileMasteryY,Skills.MagicMissileMastery);

// Remaining skill points
draw_set_alpha(1); draw_set_color(c_white);
draw_text(remainingPointsX,remainingPointsY,string(p.skillPoints) + " points remaining");

// skill description
//showSkillInfo(skillSelector.selectedSkill);
if skillSelector != noone {
	showSkillInfo(skillSelector.selectedSkill);
}