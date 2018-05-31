/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if enemyData == noone {
	global.enemy = id;
	instance_create_depth(x,y,1,obj_enemy_data);
}

with obj_enemy_data {
	if key == other.key {
		other.isAlive = isAlive;
		if isAlive {
			other.isShowingLightRadius = true;
		}
		other.hp = hp;
		other.x = currentX;
		other.y = currentY;
		other.layer = currentZ;
		other.tempPostX = tempPostX;
		other.tempPostY = tempPostY;
		other.enemyData = id;
	}
}