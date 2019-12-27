/// scr_evl_dybukkboss_teleport_on_damage
/// @param params array [victim, damageAmount]

var arr = argument[0];
var victim = arr[0];
if (victim == id) {
	var dmgAmount = arr[1];
	damageTaken += dmgAmount;
	
	if damageTaken > DAMAGE_TO_TELEPORT && alarm[4] <= 0 {
		randomize();
		alarm[4] = random_range(TELEPORT_PREP_FRAME_MIN, TELEPORT_PREP_FRAME_MAX);
	}
}