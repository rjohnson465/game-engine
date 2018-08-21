/// handleBlockedAttack(attackObj,assailant,damagesTaken,actualDamage,isCriticalHit,itemHitWith,attackData)
/// @param attackObj
/// @param assailant
/// @param damagesTaken
/// @param actualDamage
/// @param isCriticalHit
/// @param itemHitWith
/// @param attackData

var attackObj = argument[0];
var assailant = argument[1];
var damagesTaken = argument[2];
var actualDamage = argument[3];
var isCriticalHit = argument[4];
var itemHitWith = argument[5];
var attackData = argument[6];

var shield = ds_map_find_value(equippedLimbItems, "l");
if !object_is_ancestor(shield.object_index,obj_shield_parent) shield = ds_map_find_value(equippedLimbItems, "r");
var dt = shield.material == WOOD ? "Dust" : "Block";
global.damageType = dt;
global.x1 = __x;
global.y1 = __y;
global.particleDirection = facingDirection;
global.hitParticlesLayer = layer;
instance_create_depth(0,0,1,obj_hit_particles);
var snd = shield.material == WOOD ? snd_shield_hit_wood : snd_shield_hit_metal;
audio_play_sound_at(snd,__x,__y,depth,100,100,1,0,1);
var shield = ds_map_find_value(equippedLimbItems,"r");
					
// remove the same percentage of stamina as it would have removed health
var percentageOfHealth = actualDamage / maxHp;
stamina -= maxStamina*(percentageOfHealth*1.5);
// shields are only ever held in left hand
				
// damage needs to be refactored, as shields have their own defenses per element
var currentDamageType = ds_map_find_first(damagesTaken);
var adjustedDamage = 0;
for (var i = 0; i < ds_map_size(damagesTaken); i++) {
					
	var defense = ds_map_find_value(shield.defenses,currentDamageType);
	var damageTaken = ds_map_find_value(damagesTaken,currentDamageType);
	adjustedDamage += ((100-defense)/100)*damageTaken;
					
	currentDamageType = ds_map_find_next(damagesTaken,currentDamageType);
}
				
hp -= adjustedDamage;
global.damageAmount = adjustedDamage;
global.victim = id;
global.healingSustained = 0;
global.isCriticalHit = isCriticalHit;
instance_create_depth(x,y,1,obj_damage);
if stamina < 1 {
	isShielding = false;
	// if no more stamina, stagger (slow stagger)
	path_end();
	state = CombatantStates.Staggering;
	staggerFrame = 0;
	staggerDuration = 25; // TODO Devin fix later
	staggerSpeed = 1;
}	
// stagger assailant iff assailant weapon / attack staggers against blocks
var itemOrAttack = attackData != noone ? attackData : itemHitWith;
if itemOrAttack.staggersAgainstBlocks {
	with assailant {
		var itemIsMelee = false;
		if itemHitWith != noone {
			itemIsMelee = itemHitWith.subType == HandItemTypes.Melee;
		}
		var pred = assailant.type == CombatantTypes.Player ? itemIsMelee : assailant.currentMeleeAttack != noone;
		if pred {
			isShielding = false;
			path_end();
			staggerFrame = 0;
			staggerDuration = 30;
			staggerDirection = (attackObj.owner.facingDirection+180)%360;;
			staggerSpeed = 3;
			state = CombatantStates.Staggering;
		}
	}
}
				
// damage shield durability (1/10 of attack's damage)
if type == CombatantTypes.Player {
	damageItem(shield,.1*actualDamage);
}
				
// damage weapons that strike shields 
if attackObj.owner.type == CombatantTypes.Player && attackObj.isMelee {
	if attackObj.weapon.weaponType != UNARMED {
		damageItem(itemHitWith,.15*actualDamage);
	}
}