/// drawSkillSlot(x,y,slot)
/// @param x
/// @param y
/// @param slot

var xx = argument0;
var yy = argument1;
var slot = argument2;
var ui = global.ui; 

var drawDark = false;
with obj_skill_selector {
	if x1 == xx && y1 == yy {
		drawDark = true;
	} 
}
if drawDark {
	draw_sprite_ext(spr_item_slot,1,xx,yy,1,1,0,c_gray,.75);
} else {
	draw_sprite(spr_item_slot,1,xx,yy);
}

var sprite = spr_item_leathercap;
switch slot {
	case Skills.HealthMax: {
		sprite = spr_skill_hpmax; break;
	}
	case Skills.MagicMissileMastery: {
		sprite = spr_item_magicmissile_magic; break;
	}
	case Skills.BlastMastery: {
		sprite = spr_item_projectile_magic; break;
	}
	case Skills.ExplosionMastery: {
		sprite = spr_item_aoe_magic; break;
	}
}

draw_sprite(sprite,1,xx,yy);

var skill = noone;
switch slot {
	case Skills.HealthMax: {
		skill = obj_skill_hpmax; break;
	}
}

if skill 
scr_draw_text_outline(skill.x1,skill.y1,skill.level,c_white,c_white);

