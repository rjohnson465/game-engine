if global.enemy != noone {
	enemy = global.enemy;


	key = fs_generate_key(enemy);

	postX = enemy.postX;
	postY = enemy.postY;
	postZ = enemy.postZ;
	tempPostX = noone;
	tempPostY = noone;
	currentX = postX;
	currentY = postY;
	currentZ = postZ;
	hp = enemy.hp;
	maxHp = enemy.maxHp;
	isAlive = enemy.isAlive;
	facingDirection = enemy.facingDirection;
} 
/*
else {
	postX = 0;
	postY = 0;
	postZ = 0;
	tempPostX = noone;
	tempPostY = noone;
	currentX = 0;
	currentY = 0;
	currentZ = 0;
	hp = 0;
	maxHp = 0;
	isAlive = true;
}