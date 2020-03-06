/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

var p = global.player;
if isInUse {
	
	var currentHp = p.hp;
	p.hp += 20;
	
	var hpHealed = currentHp + 20 > p.maxHp ? p.maxHp - currentHp : 20;
	
	// healing text
	global.victim = p;
	global.damageAmount = hpHealed;
	global.healingSustained = 0;
	global.isCriticalHit = false;
	var healingText = instance_create_depth(x, y, 1, obj_damage);
	healingText.color = c_lime;
	
	isInUse = false;
}