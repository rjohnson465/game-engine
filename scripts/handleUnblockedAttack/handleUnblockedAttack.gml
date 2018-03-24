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

hp -= damage;	
global.damageAmount = damage;
global.healingSustained = 0;
global.victim = id;
global.isCriticalHit = isCriticalHit; // critical?
instance_create_depth(x,y,1,obj_damage);
// if assailant was player, damage their weapon a bit
if assailant.type == CombatantTypes.Player && attackObj.isMelee {
	if attackObj.weapon.weaponType != UNARMED {
		damageItem(itemHitWith,.05*actualDamage);
	}
}