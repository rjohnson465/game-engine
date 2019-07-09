if !ui.isShowingMenus || ui.currentMenu != SKILLS exit;

draw_set_color(c_black);
draw_rectangle(topLeftX,topLeftY,bottomRightX,skillDescriptionBottomRightY,1);

var p = global.player;

if !isActive && gamepad_is_connected(p.gamePadIndex) draw_set_alpha(.5);
else draw_set_alpha(1);

// General skills
drawSkillSlot(healthMaxX,healthMaxY,Skills.HealthMax,skillHpMax);
drawSkillSlot(staminaMaxX,staminaMaxY,Skills.StaminaMax,skillStaminaMax);
drawSkillSlot(offHandMasteryX,offHandMasteryY,Skills.OffHandDamage,skillAmbidextrous);
drawSkillSlot(poiseMinX,poiseMinY,Skills.EquipLoad,skillEquipLoad);

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
draw_set_color(c_black); var rw = 150;
var x1 = remainingPointsX-rw; var x2 = remainingPointsX;
var y1 = remainingPointsY; var y2 = remainingPointsY+25;
draw_rectangle(x1, y1, x2, y2,0);
draw_set_alpha(1); draw_set_color(c_white);
draw_rectangle(x1, y1, x2, y2,1);
var s = string(p.skillPoints);
s += p.skillPoints == 1 ? " skill point" : " skill points";
var sw = string_width(s); var xs = 1;
if sw > rw {
	xs = rw/sw;
}
draw_set_halign(fa_center); draw_set_valign(fa_center);
draw_text_transformed(mean(x1,x2),mean(y1,y2),s,xs,xs,0);

// selected item details box
draw_set_color(c_dkgray);
draw_rectangle(skillDescriptionTopLeftX,skillDescriptionTopLeftY,skillDescriptionBottomRightX-1,skillDescriptionBottomRightY,false);

// skill description
if skillSelector != noone {
	showSkillInfo(skillSelector.selectedSkill);
}

// prompts
// draw prompts
var promptsStartX = MENUS_TOPLEFT_X+18;
var promptsY = MENUS_BOTTOMRIGHT_Y+25;
var xOffset = 20;
var w = 0;
if ui.currentMenu == SKILLS && skillSelector.selectedSkill && skillSelector.selectedSkill != noone && isActive {
	// controller prompts
	if gamepad_is_connected(global.player.gamePadIndex) {
		if global.player.skillPoints > 0 {
			w += drawPrompt("Level up " + string(skillSelector.selectedSkill.name), Input.F,promptsStartX+w,promptsY)+xOffset;
		}
		w += drawPrompt("Browse quests", Input.RB,promptsStartX+w,promptsY)+xOffset;
	}
	// m/k prompts
	else {
		
		var hoveredSkill = noone;
		with obj_skill_parent {
			if point_in_rectangle(mouse_x,mouse_y,bbox_left,bbox_top,bbox_right,bbox_bottom) {
				hoveredSkill = id;
			}
		}
		
		/*if hoveredSkill != noone {
			w += drawPrompt("Level up " + string(hoveredSkill.name), Input.RMB,promptsStartX+w,promptsY)+xOffset;
		}
		else {
			w += drawPrompt("Level up skill", Input.RMB,promptsStartX+w,promptsY)+xOffset;
		}*/
		
		//w += drawPrompt("Select quest", Input.LMB,promptsStartX+w,promptsY)+xOffset;
	}
}

draw_set_alpha(1);