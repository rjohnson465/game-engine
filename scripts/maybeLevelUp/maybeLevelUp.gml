// level up?
if (xp + xpTemp) >= xpToNextLevel {
	var remainingXp = (xp+xpTemp)-xpToNextLevel;
	xp = 0; xpTemp = remainingXp;
	level += 1;
	
	/*
	with obj_npc_parent {
		isInteractingWithPlayer = false;
		isInConversation = false;
		showBuySell = false;
	}
	global.isInteractingWithNpc = false;
	global.isTrading = false;
	*/
	
	// xpToNextLevel = round(1000*(power(level,1.1)));
	xpToNextLevel = getXpToNextLevel();
	skillPoints++;
	alert("Level " + string(level) + " reached!",c_lime,90);
	audio_play_sound(snd_levelup,1,0);
	
	hp = maxHp;
	stamina = maxStamina;
	
	global.damageType = "LevelUp"; global.x1 = x; global.y1 = y; global.particleDirection = noone;
	global.hitParticlesLayer = layer; global.victim = id;
	instance_create_depth(x,y,1,obj_hit_particles);
	room_speed = 15;
	alarm[0] = 15;
	
	var hasTaughtLevelUp = ds_map_find_value(tutorialFirstsMap, TutFirsts.LevelingUp);
	if !hasTaughtLevelUp {
		var msg = "You've leveled up! Each level, you get a skill point, which can be spent in the skills menu. Choose wisely!";
		showTutorialMessage(msg,[],[],TutFirsts.LevelingUp);
	}
	
}