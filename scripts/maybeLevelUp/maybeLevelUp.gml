// level up?
if (xp + xpTemp) >= xpToNextLevel {
	var remainingXp = (xp+xpTemp)-xpToNextLevel;
	xp = 0; xpTemp = remainingXp;
	level += 1;
	xpToNextLevel = round(1000*(power(level,1.1)));
	skillPoints++;
	alert("Level " + string(level) + " reached!",c_lime,90);
	audio_play_sound(snd_levelup,1,0);
	
	global.damageType = "LevelUp"; global.x1 = x; global.y1 = y; global.particleDirection = noone;
	global.hitParticlesLayer = layer; global.victim = id;
	instance_create_depth(x,y,1,obj_hit_particles);
	room_speed = 15;
	alarm[0] = 15;
}