/// returnToLastFountain()
// must be called by player
/*
hp = maxHp;
stamina = maxStamina;
isDying = false;
isAlive = true;
visible = true;
alpha = 1;
room_speed = 30;
application_surface_draw_enable(true);
*/

if lastFountainRoom == noone {	
	var nearestFountain = instance_nearest(x,y,obj_fountain);
	lastFountainRoom = room_get_name(asset_get_index(nearestFountain.nativeRoom));
	lastFountainX = nearestFountain.spawnX;
	lastFountainY = nearestFountain.spawnY;
	lastFountainZ = nearestFountain.layerName;
}
				
var rm = asset_get_index(lastFountainRoom);
room_goto(rm);
x = lastFountainX;
y = lastFountainY;
				
layerToMoveTo = lastFountainZ;
justRevivedAtFountain = true;