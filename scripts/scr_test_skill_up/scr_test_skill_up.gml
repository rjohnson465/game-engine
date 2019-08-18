/// scr_test_skill_up(skillObjIndex)
/// @param skillObjIndex

var skillObjIndex = argument[0];
var skill = instance_nearest(x, y, skillObjIndex);

if instance_exists(skill) {
	levelUpSkill(skill);
}