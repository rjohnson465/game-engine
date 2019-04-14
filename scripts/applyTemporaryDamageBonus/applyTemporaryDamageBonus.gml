/// applyTemporaryDamageBonus(weapon, bonusEntry)
/// @param weapon this is an item
/// @param bonusEntry

var weapon = argument[0];
var entry = argument[1];

ds_list_add(weapon.temporaryDamages, entry);

var damageType = entry[0];
var damageAmount = entry[2];
var dal = damageAmount[0]; var dau = damageAmount[1];
var currentDamage = ds_map_find_value(weapon.damages, damageType);
var cdl = currentDamage[0]; var cdu = currentDamage[1];
var newDamage = [cdl + dal, cdu + dau];
ds_map_replace(weapon.damages, damageType, newDamage);

with obj_weapon {
	if limbItem == weapon {
		refreshParticles = true;
	}
}