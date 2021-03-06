/// makeEnemyWeapon(obj_index, *doNotUseSameIndex)
/// @param obj_index
/// @param *doNotUseSameIndex

/// must be called by a child of enemy_parent
/// when an enemy is given a weapon, the weapon is pretty much only 
/// used for booleans like isTwoHanded, and its sprite info
/// so all enemies can reference the same instance for weapon. this saves memory

var objIndex = argument[0];
var doNotUseSameIndex = false;
if argument_count > 1 {
	doNotUseSameIndex = argument[1];
}

if instance_number(objIndex) > 0 && !doNotUseSameIndex {
	with objIndex {
		if owner != noone && instance_exists(owner) && owner.object_index == other.object_index {
			return id;
		}
	}
}

var item = instance_create_depth(x,y,depth,objIndex);
item.owner = id;
item.persistent = false;
return item;
