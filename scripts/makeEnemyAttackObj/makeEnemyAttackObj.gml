/// makeEnemyAttackObj(obj_index)
/// @param obj_index
/// return a generic instance of an attack_data obj
/// this is useful so multiple instances of a certain enemy type can reference the same attack data
/// this way not every enemy uses their own objects, so memory is spared
/// if an enemy needs a modified version of an attack_data object, DO NOT use this function
/// modification of an attack data object returned by this function will change the attack data
/// for all enemies that reference that data

var objIndex = argument[0];

if instance_number(objIndex) > 0 {
	return instance_nearest(x,y,objIndex);
}
else return instance_create_depth(x,y,depth,objIndex);