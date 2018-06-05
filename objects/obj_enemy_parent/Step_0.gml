event_inherited();

if state == CombatantStates.Moving && instance_exists(enemyData) && enemyData != noone && x != postX && y != postY {
	enemyData.currentX = x;
	enemyData.currentY = y;
	enemyData.currentZ = layer;
}

