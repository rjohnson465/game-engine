if !ui.isShowingMenus || ui.currentMenu != SKILLS exit;
var p = global.player;

// General skills
drawSkillSlot(healthMaxX,healthMaxY,Skills.HealthMax,skillHpMax);
drawSkillSlot(staminaMaxX,staminaMaxY,Skills.StaminaMax,skillStaminaMax);
drawSkillSlot(offHandMasteryX,offHandMasteryY,Skills.OffHandDamage,skillAmbidextrous);

// Melee skills
drawSkillSlot(bladeMasteryX,bladeMasteryY,Skills.BladeMastery,skillBladeMastery);
drawSkillSlot(axeMasteryX,axeMasteryY,Skills.AxeMastery,skillAxeMastery);
drawSkillSlot(clubMasteryX,clubMasteryY,Skills.ClubMastery,skillClubMastery);
drawSkillSlot(pointyMasteryX,pointyMasteryY,Skills.PointyMastery,skillPointyMastery);

// Ranged Skills
drawSkillSlot(bowMasteryX,bowMasteryY,Skills.BowMastery,skillBowMastery);
drawSkillSlot(gunMasteryX,gunMasteryY,Skills.GunMastery,skillGunMastery);
drawSkillSlot(assassinMasteryX,assassinMasteryY,Skills.AssassinMastery,skillAssassinMastery);

// Magic skills
drawSkillSlot(blastMasteryX,blastMasteryY,Skills.BlastMastery,skillBlast);
drawSkillSlot(explosionMasteryX,explosionMasteryY,Skills.ExplosionMastery,skillExplosion);
drawSkillSlot(magicMissileMasteryX,magicMissileMasteryY,Skills.MagicMissileMastery,skillMagicMissile);

// Remaining skill points
draw_set_alpha(1); draw_set_color(c_white);
draw_text(remainingPointsX,remainingPointsY,string(p.skillPoints) + " points remaining");

// skill description
//showSkillInfo(skillSelector.selectedSkill);
if skillSelector != noone {
	showSkillInfo(skillSelector.selectedSkill);
}