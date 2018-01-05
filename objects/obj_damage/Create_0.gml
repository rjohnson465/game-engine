amount = global.damageAmount;
type = global.damageType;
victim = global.victim;
frame = 0;
totalFrames = 30;

// TODO display only one damage count for each victim
var damagesCount = instance_number(obj_damage);
for (var i = 0; i < damagesCount; i++) {
	var d = instance_find(obj_damage,i);
	if d != noone && d.victim == victim && d.id != id {
		global.amount = d.amount + amount;
		global.damageType = type;
		global.victim = victim;
		instance_destroy(d.id,false);
		instance_destroy(id,false);
		instance_create_depth(x,y,1,obj_damage);
		
	}
}