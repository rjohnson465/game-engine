event_inherited();

if state == CombatantStates.Moving && enemyData != noone && x != postX && y != postY {
	enemyData.currentX = x;
	enemyData.currentY = y;
}

