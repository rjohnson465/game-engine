/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if enemyData == noone || !instance_exists(enemyData) {
	state = CombatantStates.Idle;
	lockOnTarget = noone;
	global.enemy = id;
	instance_create_depth(x,y,1,obj_enemy_data);
}

with obj_enemy_data {
	if key == other.key {
		other.isAlive = isAlive;
		if isAlive || hp < 0 {
			other.isShowingLightRadius = true;
			other.x = currentX;
			other.y = currentY;
		} else {
			other.x = -1000;
			other.y = -1000;
		}
		other.hp = hp;
		
		other.layer = currentZ;
		other.tempPostX = tempPostX;
		other.tempPostY = tempPostY;
		other.enemyData = id;
		other.facingDirection = facingDirection;
	}
}