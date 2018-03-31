/// makeSkillObj(skillObj,x,y)
/// @param skillObj
/// @param x
/// @param y

var skillObj = argument[0];
global.x1 = argument[1];
global.y1 = argument[2];

// construct relational data for each slot
/*switch (global.skillSlot) {
	case Skills.HealthMax: {
		global.down = Skills.StaminaMax;
	}
}*/

instance_create_depth(global.x1,global.y1,1,skillObj);