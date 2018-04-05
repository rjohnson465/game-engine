ui = global.ui;
inventory = global.inventory;
global.skillManager = id;
skillSelector = noone;

enum Skills {
	HealthMax,
	StaminaMax,
	OffHandDamage,
	BladeMastery,
	AxeMastery,
	ClubMastery,
	PointyMastery,
	BowMastery,
	GunMastery,
	AssassinMastery,
	BlastMastery,
	ExplosionMastery,
	MagicMissileMastery
}

topLeftX = MENUS_TOPLEFT_X;
topLeftY = MENUS_TOPLEFT_Y+ui.menusHandleHeight+ui.menuTabsHeight;
width = (MENUS_BOTTOMRIGHT_X - MENUS_TOPLEFT_X)/2;

skillHeight = sprite_get_height(spr_item_slot);
skillWidth = sprite_get_width(spr_item_slot);

skillDescriptionTopLeftX = topLeftX;
skillDescriptionTopLeftY = topLeftY+300;
skillDescriptionBottomRightX = topLeftX+width;
skillDescriptionBottomRightY = MENUS_BOTTOMRIGHT_Y;
skillDescriptionHandleHeight = 20;
skillDescriptionCol1X = topLeftX+5;
skillDescriptionCol2X = topLeftX+(.5*width)+5;

colWidth = width/4;
padding = (colWidth-skillWidth)/2;

// General skills
healthMaxX = topLeftX+padding;
healthMaxY = topLeftY+skillHeight+10;

staminaMaxX = healthMaxX;
staminaMaxY = healthMaxY+skillHeight+5;

offHandMasteryX = healthMaxX;
offHandMasteryY = staminaMaxY+skillHeight+5;

// Melee skills

bladeMasteryX = topLeftX+(width/4)+padding;
bladeMasteryY = topLeftY+5;

axeMasteryX = bladeMasteryX;
axeMasteryY = bladeMasteryY+skillHeight+5;

clubMasteryX = bladeMasteryX;
clubMasteryY = axeMasteryY+skillHeight+5;

pointyMasteryX = bladeMasteryX;
pointyMasteryY = clubMasteryY+skillHeight+5;

// Ranged skills

bowMasteryX = topLeftX+(2*(width/4))+padding;
bowMasteryY = topLeftY+5;

gunMasteryX = bowMasteryX;
gunMasteryY = bowMasteryY+skillHeight+5;

assassinMasteryX = bowMasteryX;
assassinMasteryY = gunMasteryY+skillHeight+5;

// Magic skills

blastMasteryX = topLeftX+(3*(width/4))+padding;
blastMasteryY = topLeftY+5;

explosionMasteryX = blastMasteryX;
explosionMasteryY = blastMasteryY+skillHeight+5;

magicMissileMasteryX = blastMasteryX;
magicMissileMasteryY = explosionMasteryY+skillHeight+5;

// Skill points remaining
remainingPointsX = blastMasteryX;
remainingPointsY = magicMissileMasteryY+skillHeight+skillHeight+5;

// General
makeSkillObj(obj_skill_hpmax,healthMaxX,healthMaxY);
makeSkillObj(obj_skill_staminamax,staminaMaxX,staminaMaxY);
makeSkillObj(obj_skill_offhanddamage,offHandMasteryX,offHandMasteryY);

// Melee
makeSkillObj(obj_skill_blade_mastery,bladeMasteryX,bladeMasteryY);
makeSkillObj(obj_skill_axe_mastery,axeMasteryX,axeMasteryY);
makeSkillObj(obj_skill_club_mastery,clubMasteryX,clubMasteryY);
makeSkillObj(obj_skill_pointy_mastery,pointyMasteryX,pointyMasteryY);

// Ranged
makeSkillObj(obj_skill_bow_mastery,bowMasteryX,bowMasteryY);
makeSkillObj(obj_skill_gun_mastery,gunMasteryX,gunMasteryY);
makeSkillObj(obj_skill_assassin_mastery,assassinMasteryX,assassinMasteryY);

// Spells
makeSkillObj(obj_spell_magicmissile,magicMissileMasteryX,magicMissileMasteryY);
makeSkillObj(obj_spell_projectile,blastMasteryX,blastMasteryY);
makeSkillObj(obj_spell_aoe,explosionMasteryX,explosionMasteryY);