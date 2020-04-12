amount = global.damageAmount;
bonusDamage = 0;
victim = global.victim;
healingSustained = global.healingSustained;
isCriticalHit = global.isCriticalHit;
attackHitWith = global.attackObj;
frame = 0;
totalFrames = 22;
depth = -500;

// check if bonus damage from Wolf Tooth Ring was given
if isRingActive(obj_item_ring_wolftoothring) && instance_exists(attackHitWith) && attackHitWith.owner.object_index == obj_player {
	var normalDamage = amount / 1.5;
	bonusDamage = round(amount - normalDamage);
	amount -= bonusDamage;
}

randomize();
rotationAngle = round(random_range(0, 1)) == 0 ? -1 : 1;

victimX = victim.x;
victimY = victim.y;
// make damage at victimX / Y or at point of collision
if point_in_rectangle(victim.__x, victim.__y, victim.bbox_left, victim.bbox_top, victim.bbox_right, victim.bbox_bottom) {
	victimX = victim.__x;
	victimY = victim.__y;
}

color = noone;

/*
// display only one damage count for each victim, cumulative
var damagesCount = instance_number(obj_damage);
for (var i = 0; i < damagesCount; i++) {
	var d = instance_find(obj_damage,i);
	if d != noone && d.victim == victim && d.id != id {
		global.damageAmount = d.amount + amount;
		global.healingSustained = d.healingSustained + healingSustained;
		global.victim = victim;
		instance_destroy(d.id,false);
		instance_destroy(id,false);
		instance_create_depth(x,y,1,obj_damage);
	}
}