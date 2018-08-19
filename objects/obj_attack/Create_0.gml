owner = global.owner;
depth = 1;
layer = owner.layer;
x = owner.x;
y = owner.y;
image_angle = owner.facingDirection;
originalDirection = owner.facingDirection;
facingDirection = owner.facingDirection;
weapon = noone;
limbKey = global.limbKey; // l | r is most common
isSpell = false;
isRanged = false;
isMelee = false;
attackData = noone;
combatantsHit = ds_list_create();
hasSetAlarm = false;

spell = noone;
particle = noone;
particle2 = noone;
spellElement = noone;
percentCharged = 1;
system = part_system_create();
part_system_depth(system,-4);
emitter = part_emitter_create(system);
soundEmitter = audio_emitter_create();
sound = noone;
isSoundLooping = false;

if owner.type == CombatantTypes.Player && owner.leftHandItem.isTwoHanded && owner.leftHandItem.isRanged {
	percentCharged = global.percentCharged;
}

// spell logic
if owner.currentUsingSpell != noone {
	
	isRanged = true;
	visible = true;
	isSpell = true;
	percentCharged = global.percentCharged;
	
	// spell scale dependent on percentCharged
	// 50% charged = scale of 1
	var scale = ((percentCharged*100)/100)+.5;
	image_xscale = scale; image_yscale = scale;
	
	var currentSpell = ds_map_find_value(owner.knownSpells,owner.currentUsingSpell);
	spell = currentSpell;
	
	// set spell damage type based on attunement
	for (var i = 0; i < array_length_1d(global.ALL_ELEMENTS); i++) {
		var el = global.ALL_ELEMENTS[i];
		if el == owner.currentSpellAttunement {
			spellElement = el;
			ds_map_replace(spell.damages,el,[spell.minDamage,spell.maxDamage]);
		} else {
			ds_map_replace(spell.damages,el,[0,0]);
		}
	}
	
	var attunementSpriteName = owner.currentSpellAttunement;
	if spell.spriteName != "aoe" {
		sprite_index = asset_get_index("spr_spell_"+spell.spriteName+"_"+attunementSpriteName);
	} else {
		sprite_index = asset_get_index("spr_spell_magicmissile_"+attunementSpriteName);
	}
	var totalProjectiles = spell.numberOfProjectiles;
	
	speed = spell.projectileSpeed;
	// TODO get a math major -- calculate spread dynamically, not statically
	if spell.spriteName == "magicmissile" {
		var spread = 0; var start = facingDirection;
		switch totalProjectiles {
			case 1: break;
			case 2: start = (facingDirection+360)-7.5; spread = 15; break;
			case 3: start = (facingDirection+360)-15; spread = 15; break;
			case 4: start = (facingDirection+360)-15; spread = 10; break;
			case 5: start = (facingDirection+360)-20; spread = 10; break;
		}
		var projectileNumber = global.projectileNumber;
		direction = start + (spread*projectileNumber-1);
	} else if spell.spriteName == "projectile" {
		direction = owner.facingDirection;
	} else if spell.spriteName == "aoe" {
		var spread = 360 / totalProjectiles;
		direction = spread*global.projectileNumber;
		facingDirection = direction;
	}
	
	// particles
	switch spellElement {
		case ICE: {
			// snowflake particle
			var snowflake = part_type_create();
			part_type_shape(snowflake, pt_shape_snow);
			part_type_orientation(snowflake,0,0,0,15,1);
			part_type_size(snowflake,0,0.25,0,0);
			part_type_speed(snowflake,1,1.5,0,0);
			part_type_direction(snowflake,0,360,0,4);
			part_type_life(snowflake,10,20);
			part_type_alpha3(snowflake,1,.75,.5);
			particle = snowflake;
		
			// tiny snowflake Particle
			var smallflake = part_type_create();
			part_type_shape(smallflake,pt_shape_sphere);
			part_type_size(smallflake,0,.1,0,0);
			part_type_color2(smallflake,c_white,c_ltgray);
			part_type_alpha3(smallflake,1,.75,.5); 
			part_type_speed(smallflake,1,2,0,0);
			part_type_direction(smallflake,0,360,0,0);
			part_type_blend(smallflake,1);
			part_type_life(smallflake,15,25);
			particle2 = smallflake;
			break;
		}
		case MAGIC: {
			num = random_range(10,15);
			// magic particle
			var magic = part_type_create();
			part_type_shape(magic, pt_shape_sphere);
			part_type_color2(magic,c_aqua,c_ltgray);
			part_type_orientation(magic,0,0,0,15,1);
			part_type_size(magic,0,0.07,0,0);
			part_type_speed(magic,2,8,0,0);
			part_type_direction(magic,0,360,0,4);
			part_type_life(magic,10,15);
			particle = magic;
			break;
		}
		case FIRE: {
			// cinder Particle
			var cinder = part_type_create();
			part_type_shape(cinder,pt_shape_flare);
			part_type_size(cinder,0,.1,0,0);
			part_type_color2(cinder,c_orange,c_red);
			part_type_alpha3(cinder,1,1,0); 
			part_type_speed(cinder,1,2,0,0);
			part_type_direction(cinder,85,95,0,0);
			part_type_blend(cinder,1);
			part_type_life(cinder,25,50);
			particle = cinder;
			break;
		}
		case POISON: {
			// poison clouds
			var poison = part_type_create();
			part_type_shape(poison, pt_shape_cloud);
			part_type_orientation(poison,0,359,0,15,1);
			part_type_size(poison,0.1,.45,0,0);
			part_type_speed(poison,.5,.75,0,0);
			part_type_direction(poison,0,360,0,4);
			part_type_life(poison,15,20);
			part_type_color2(poison,c_green,c_olive);
			part_type_alpha3(poison,.75,.5,.25);
			particle = poison;
			break;
		}
		case LIGHTNING: {
			var spark = part_type_create();
			part_type_shape(spark, pt_shape_spark);
			part_type_orientation(spark,0,359,0,15,1);
			part_type_size(spark,0.01,.15,0,0);
			part_type_speed(spark,8,12,0,0);
			part_type_direction(spark,0,360,0,4);
			part_type_life(spark,3,6);
			part_type_color2(spark,c_purple,c_white);
			part_type_alpha3(spark,1,.85,.75);
			particle = spark;
			break;
		}
	}
}

// spells have light radii
if isSpell {
	isSoundLooping = true;
	lightRadius = 256;
	lightRadiusAlpha = calculateLightRadiusAlpha();
	if lightRadiusAlpha <=.01 {
		lightRadiusAlpha = .3;
	}
	lightRadiusScale = .15;
	if spell.spriteName == "projectile" {
		lightRadiusScale = .23;
	}
	lightRadiusColor = c_white;
	switch (attunementSpriteName) {
		case "magic": {
			lightRadiusColor = c_white;
			break;
		}
		case "fire": {
			lightRadiusColor = c_orange;
			sound = snd_magic_fire;
			break;
		}
		case "ice": {
			lightRadiusColor = c_white;
			sound = snd_magic_ice;
			break;
		}
		case "poison": {
			lightRadiusColor = c_lime;
			sound = snd_magic_poison;
			break;
		}
		case "lightning": {
			lightRadiusColor = c_purple;
			sound = snd_magic_lightning;
			break;
		}
	}
	lightRadiusSprite = spr_light_point;
	isShowingLightRadius = true;
	global.owner = id;
	global.makeLightOnCreate = true;
	instance_create_depth(x,y,1,obj_light_radius);

}

// ranged or melee: NOT A SPELL
else {
	weapon = ds_map_find_value(owner.equippedLimbItems,limbKey);
	// get attack number
	if owner.type != CombatantTypes.Player {
		isRanged = owner.currentMeleeAttack == noone ? true: false;
		isMelee = owner.currentMeleeAttack == noone ? false : true;
		attackNumber = owner.currentMeleeAttack == noone ? owner.currentRangedAttack : owner.currentMeleeAttack;
		attackNumberInChain = ds_map_find_value(owner.attackingLimbs,limbKey);
		if isMelee {
			var attackChain = owner.meleeAttacks[attackNumber];
			attackData = attackChain[attackNumberInChain-1];
		} else {
			var attackChain = owner.rangedAttacks[attackNumber];
			attackData = attackChain[attackNumberInChain-1];
		}
	} else {
		attackNumber = ds_map_find_value(owner.attackingLimbs,limbKey);
		attackNumberInChain = ds_map_find_value(owner.attackingLimbs,limbKey);
		
		isRanged = weapon.subType == HandItemTypes.Ranged;
		isMelee = weapon.subType == HandItemTypes.Melee;
	}

	if isMelee && owner.isSlowed {
		image_speed = .5; // TODO
	}
	
	// get current attacking limb item sprite name (or "")
	attackItemSprite = "";
	if owner.hasHands {
		attackItemSprite = "_"+ ds_map_find_value(owner.equippedLimbItems,limbKey).spriteName;
	} else attackItemSprite = ""; // TODO for enemies/attacks without hands


	// get sprite string -- physical attacks
	var sprStr = ""; var maskString = "";
	if owner.type == CombatantTypes.Player {
		sprStr = "spr_"+owner.spriteString+attackItemSprite+"_attack_"+string(attackNumber);
		maskString = sprStr + "_mask";
		visible = true;
	} else {
		//sprStr = "_"+string(owner.attackNumberInChain);
		sprStr = attackData.spriteName + "_attack_" + string(attackData.spriteAttackNumber) + "_" + string(attackData.spriteAttackNumberInChain);
	}

	// if this is a left hand attack, flip yscale TODO
	if !(limbKey == "r" || (weapon.isRanged && weapon.isTwoHanded)) {
		image_yscale = -1;
	}
	
	if asset_get_index(maskString) != -1 {
		sprite_index = asset_get_index(maskString);
	} else {
		sprite_index = asset_get_index(sprStr);
	}
	
	// ranged attacks 
	if isRanged {
		visible = true;
		if weapon {
			speed = weapon.projectileSpeed;
		} else {
			speed = attackData.projectileSpeed;
		}
		direction = owner.facingDirection;
		facingDirection = direction; // facingDirection property needed for is_facing script
	
		var recoverSprite = asset_get_index("spr_"+owner.spriteString+attackItemSprite+"_recover_"+string(attackNumber));
		if owner.type != CombatantTypes.Player {
			var sprStr = "spr_"+owner.spriteString+attackItemSprite+"_recover_"+string(attackNumber)+"_"+string(attackNumberInChain);
			var recoverSprite = asset_get_index(sprStr);
		}
	
		owner.stupidityFrame = 0;

		// set recoveringLimbs at limbKey to the attackNumberInChain that is recovering
		var attackInChain = ds_map_find_value(owner.attackingLimbs,limbKey);
		ds_map_replace(owner.recoveringLimbs,limbKey,attackInChain);
		
		// set recoverFrames to -1
		ds_map_replace(owner.recoverFrames,limbKey,-1);
		
		// remove limbKey from attackingLimbs map
		ds_map_delete(owner.attackingLimbs,limbKey);
		
		owner.prevAttackHand = limbKey;
	} else {
		image_alpha = .5;
	}
	if (weapon != noone && owner.type == CombatantTypes.Player) {
		if array_length_1d(weapon.attackSounds) >= attackNumberInChain {
			sound = weapon.attackSounds[attackNumberInChain-1];
		} else {
			sound = weapon.attackSounds[attackNumberInChain-1];
		}
	}
	else if attackData != noone {
		sound = attackData.attackSound;
	}
}

//audio_play_sound_at(sound,x,y,0,10,30,2,isSoundLooping,1);
if isSoundLooping {
	audio_play_sound_on(soundEmitter,sound,isSoundLooping,1);
} else {
	if owner.type == CombatantTypes.Player {
		audio_play_sound(sound,1,0);
	} else {
		audio_play_sound_at(sound,owner.x,owner.y,0,100,300,1,0,1);
	}
}

// special case -- guns create fire / smoke particles when attack starts
if weapon == noone exit;
if (weapon != noone && weapon.weaponType == PISTOL || weapon.weaponType == MUSKET) {

	// knockback
	var kb = weapon.weaponType == PISTOL ? 4 : 6;
	with owner {
		var isEnemy = type == CombatantTypes.Enemy;
		moveToNearestFreePoint((facingDirection+180)%360,kb,isEnemy);
	}

	var fire = part_type_create();
	part_type_sprite(fire,spr_particle_fire,0,0,1);
	part_type_size(fire,.05,.12,0,0);
	part_type_color2(fire,c_orange,make_color_rgb(128,9,9));
	part_type_alpha3(fire,1,1,0);
	part_type_speed(fire,3,5,0,0);
	part_type_direction(fire,owner.facingDirection-90,owner.facingDirection+90,0,5);
	part_type_orientation(fire,0,359,0,0,0);
	part_type_blend(fire,1);
	part_type_life(fire,6,10);
	particle = fire;
	
	var smoke = part_type_create();
	part_type_shape(smoke,pt_shape_cloud);
	part_type_size(smoke,.05,.2,.01,.03);
	part_type_color2(smoke,c_gray,c_white);
	part_type_alpha3(smoke,1,.5,.1);
	part_type_speed(smoke,1,2,.1,.1);
	part_type_direction(smoke,owner.facingDirection,owner.facingDirection,0,0);
	part_type_life(smoke,10,20);
	particle2 = smoke;
	
	var xo = weapon.sparksXOffset; var yo = weapon.sparksYOffset;
	if limbKey == "r" {
		yo += 20;
	}
	var ofd = owner.facingDirection;
	var sx = owner.x + xo; var sy = owner.y + yo;
	var cx = owner.x; var cy = owner.y;
	var radians = (pi/180) * ofd;
	var cs = cos(radians);
	var sn = sin(radians);
	var nx = (cs * (sx - cx)) + (sn * (sy - cy)) + cx;
	var ny = (cs * (sy - cy)) - (sn * (sx - cx)) + cy;
	
	xx = nx;
	yy = ny;

	part_emitter_region(system,emitter,
		xx,xx,
		yy,yy,0,0);
	part_emitter_burst(system,emitter,particle,5);
	part_emitter_burst(system,emitter,particle2,2);
}
