/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

var p = global.player;
if isInUse {
	
	var maxHp = p.maxHp;
	var hpDrained = maxHp * .25 > p.hp ? p.hp : maxHp * .25;;
	p.hp -= hpDrained;

	// health drain text
	global.victim = p;
	global.damageAmount = hpDrained;
	global.healingSustained = 0;
	global.isCriticalHit = false;
	var healingText = instance_create_depth(x, y, 1, obj_damage);
	healingText.color = c_red;
	
	with p {
		cureAllConditions();
	}
	
	isInUse = false;
}