/// handleUnblockedAttack(attackObj,assailant,damage,actualDamage,isCriticalHit,itemHitWith)
/// @param attackObj
/// @param assailant
/// @param damage
/// @param actualDamage
/// @param isCriticalHit
/// @param itemHitWith

var attackObj = argument[0];
var assailant = argument[1];
var damage = argument[2];
var actualDamage = argument[3];
var isCriticalHit = argument[4];
var itemHitWith = argument[5];

lastAttackHitWith = attackObj.attackData != noone ? attackObj.attackData : attackObj.weapon;

hp -= damage;	
global.damageAmount = damage;
global.healingSustained = 0;
global.victim = id;
global.isCriticalHit = isCriticalHit; // critical?
instance_create_depth(x,y,1,obj_damage);
// if assailant was player, damage their weapon a bit
if assailant.type == CombatantTypes.Player && attackObj.isMelee {
	if attackObj.weapon.weaponType != UNARMED {
		// this has the bug (feature??) of making it so low-durability weapons that are buffed a lot
		// died quicker
		var damageAmnt = 05*actualDamage;
		// this makes it so the max durability damage that can be done is 2, is this ok?
		if damageAmnt > 2 {
			damageAmnt = 2;
		}
		damageItem(itemHitWith,.05*actualDamage);
	}
}

// maybe vocalize
if array_length_1d(soundsWhenHitVocals) != 0 && hp >= 1 {
	randomize();
	var rand = round(random_range(-1,array_length_1d(soundsWhenHitVocals)-1));
	if rand >= 0 {
		var snd = soundsWhenHitVocals[rand];
		if snd && snd != noone {
			audio_play_sound_at(snd,x,y,depth,100,AUDIO_MAX_FALLOFF_DIST,1,0,1);
		}
	}
}