ui = global.ui;
inventory = global.inventory;
global.skillManager = id;
skillSelector = noone;

enum Skills {
	HealthMax,
	StaminaMax,
	BladeMastery,
	AxeMastery,
	ClubMastery,
	PointyMastery
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

healthMaxX = topLeftX+5;
healthMaxY = topLeftY+skillWidth;

staminaMaxX = topLeftX+5;
staminaMaxY = healthMaxY+skillHeight;

bladeMasteryX = topLeftX+(width/4)
bladeMasteryY = topLeftY;

makeSkillObj(obj_skill_hpmax,healthMaxX,healthMaxY);
makeSkillObj(obj_skill_staminamax,staminaMaxX,staminaMaxY);
makeSkillObj(obj_skill_blade_mastery,bladeMasteryX,bladeMasteryY);
