npc = global.npc;
conversations = ds_map_create(); // name / isFinished
for (var i = 0; i < ds_list_size(npc.conversations); i++) {
	var c = ds_list_find_value(npc.conversations,i);
	ds_map_replace(conversations,c.name,c.isFinished);
}
//ds_list_copy(conversations,npc.conversations);

/*
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