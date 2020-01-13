/// scr_evl_exstep_magic_lightningmissiles(arr)
/// @param arr [victim, dmgAmount, *attackObj]

// make sure victim was hit with a poison blast

var arr = argument[0];
var victim = arr[0];
var attackObj = noone;
if array_length_1d(arr) >= 3 {
	attackObj = arr[2];
}

if attackObj.spell < 0 exit;

var isRightSpell = attackObj.spell.object_index == obj_spell_magicmissile;
var isRightElement = attackObj.spellElement == LIGHTNING;

if (victim == exercise.enemy && isRightSpell && isRightElement) {
	hitsReceived++;
}