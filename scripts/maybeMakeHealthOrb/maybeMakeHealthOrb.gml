/// maybeMakeHealthOrb()
/// must be called by combatant

// first, if the player's health flask is already full, do not drop anything
var hf = instance_nearest(x,y,obj_item_health_flask);
var charges = ds_map_find_value(hf.customItemProperties, hfs_charges);
var maxCharges = ds_map_find_value(hf.customItemProperties, hfs_max_charges);
if (charges >= maxCharges) exit;

randomize();
var rand = random_range(0,1);
if rand < chanceToDropHealthOrb {
	global.fromEnemyIndex = id;
	instance_create_depth(x,y,1,obj_health_orb);
}