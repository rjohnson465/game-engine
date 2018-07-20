/// getSkillForItem(item)
/// @param item
/// item must be a weapon

var item = argument[0];

if item.weaponType == undefined exit;
if item.weaponType == noone exit;

var skill = noone;
switch item.weaponType {
	case SWORD1H: {
		skill = obj_skill_blade_mastery; break;
	}
	case SWORD2H: {
		skill = obj_skill_blade_mastery; break;
	}
	case DAGGER: {
		skill = obj_skill_blade_mastery; break;
	}
	case AXE1H: {
		skill = obj_skill_axe_mastery; break;
	}
	case AXE2H: {
		skill = obj_skill_axe_mastery; break;
	}
	case BLUNT1H: {
		skill = obj_skill_club_mastery; break;
	}
	case BLUNT2H: {
		skill = obj_skill_club_mastery; break;
	}
	case RAPIER: {
		skill = obj_skill_pointy_mastery; break;
	}
	case SPEAR: {
		skill = obj_skill_pointy_mastery; break;
	}
	case BOW: {
		skill = obj_skill_bow_mastery; break;
	}
	case CROSSBOW: {
		skill = obj_skill_bow_mastery; break;
	}
	case SHURIKEN: {
		skill = obj_skill_assassin_mastery; break;
	}
	case THROWN: {
		skill = obj_skill_assassin_mastery; break;
	}
	case MUSKET: {
		skill = obj_skill_gun_mastery; break;
	}
	case PISTOL: {
		skill = obj_skill_gun_mastery; break;
	}
}

return skill;