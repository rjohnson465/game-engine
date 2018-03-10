amount = global.damageAmount;
victim = global.victim;
healingSustained = global.healingSustained;
frame = 0;
totalFrames = 22;
//depth = -500;
layer = victim.layer;

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