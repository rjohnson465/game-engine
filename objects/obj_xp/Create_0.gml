amount = global.xpAmount;
frame = 0;
totalFrames = 60;
depth = -500;

// display only one xp num, cumulative
var xpCount = instance_number(obj_xp);
for (var i = 0; i < xpCount; i++) {
	var d = instance_find(obj_xp,i);
	if d != noone && d != id {
		global.xpAmount = d.amount + amount;
		instance_destroy(d.id,false);
		instance_destroy(id,false);
		instance_create_depth(x,y,1,obj_xp);
	}
}