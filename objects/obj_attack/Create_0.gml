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
isSpell = owner.currentUsingSpell != noone;
isRanged = false;
isMelee = false;
attackData = noone;
combatantsHit = ds_list_create();
hasSetAlarm = false;
isOnFire = false; // for arrows that pass through torches
additionalDamages = ds_map_create();

life = 60; // frames before ranged attack fades away

spell = noone;
particle = noone;
particle2 = noone;
spellElement = noone;
percentCharged = 1;
system = part_system_create();
part_system_depth(system,layer_get_depth(owner.layer));
emitter = part_emitter_create(system);
soundEmitter = audio_emitter_create();
audio_emitter_falloff(soundEmitter, 50, AUDIO_MAX_FALLOFF_DIST, 1);
sound = noone;
isSoundLooping = false;

weaponParticles = [noone, noone, noone, noone, noone];
weaponParticlesNums = [noone, noone, noone, noone, noone];

// determine attack type
if isSpell {
	instance_change(obj_attack_spell,1); exit;
}
if owner.type != CombatantTypes.Player {
	isRanged = owner.currentMeleeAttack == noone ? true: false;
	isMelee = owner.currentMeleeAttack == noone ? false : true;
} else {
	weapon = ds_map_find_value(owner.equippedLimbItems,limbKey);
	isRanged = weapon.subType == HandItemTypes.Ranged;
	isMelee = weapon.subType == HandItemTypes.Melee;
}

if owner.type == CombatantTypes.Player && owner.leftHandItem.isTwoHanded && owner.leftHandItem.isRanged {
	percentCharged = global.percentCharged;
}

// ranged or melee: NOT A SPELL
weapon = ds_map_find_value(owner.equippedLimbItems,limbKey);
if weapon == undefined weapon = noone;
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

// sounds
if (weapon != noone && owner.type == CombatantTypes.Player) {
	if array_length_1d(weapon.attackSounds) >= attackNumberInChain {
		sound = weapon.attackSounds[attackNumberInChain-1];
	} else {
		sound = weapon.attackSounds[attackNumberInChain-1];
	}
}
else if attackData != noone {
	sound = attackData.attackSound;
	var vocalsSound = noone;
	if array_length_1d(attackData.attackSoundsVocals) != 0 {
		randomize();
		var rand = round(random_range(-1,array_length_1d(attackData.attackSoundsVocals)-1));
		if rand >= 0 {
			vocalsSound = attackData.attackSoundsVocals[rand];
			audio_play_sound_at(vocalsSound, owner.x, owner.y, owner.depth, 50, AUDIO_MAX_FALLOFF_DIST, 1, 0, 1);
		}
	}
}


if isSoundLooping {
	if !audio_is_playing(sound) {
		audio_play_sound_on(soundEmitter,sound,isSoundLooping,1);
	}
} else {
	if owner.type == CombatantTypes.Player {
		audio_play_sound(sound,1,0);
	} else {
		audio_play_sound_at(sound,owner.x,owner.y,0,100,AUDIO_MAX_FALLOFF_DIST,1,0,1);
	}
}

if attackData != noone && attackData.type == AttackTypes.AOE {
	// create "projectileNumber" of aoe attack objs
	for (var i = 0; i < attackData.numberOfProjectiles; i++) {
		global.attackData = attackData;
		global.projectileNumber = i;
		instance_create_depth(x,y,depth,obj_attack_aoe);
	}
	instance_change(obj_attack_aoe,1); 
	
	// start recovery
	// set recoveringLimbs at limbKey to the attackNumberInChain that is recovering
	var attackInChain = ds_map_find_value(owner.attackingLimbs,limbKey);
	ds_map_replace(owner.recoveringLimbs,limbKey,attackInChain);
		
	// set recoverFrames to -1
	ds_map_replace(owner.recoverFrames,limbKey,-1);
		
	// remove limbKey from attackingLimbs map
	ds_map_delete(owner.attackingLimbs,limbKey);
		
	owner.prevAttackHand = limbKey;
	exit;
}

if attackData != noone && attackData.type == AttackTypes.MultiRand {
	// create "projectileNumber" of multi rand prep attack objs
	for (var i = 0; i < attackData.numberOfProjectiles; i++) {
		randomize();
		var xo = random_range(0, attackData.mrOffset);
		var yo = random_range(0, attackData.mrOffset);
		var target = owner.lockOnTarget != noone ? owner.lockOnTarget : owner;
		var xd = random_range(0,360); var yd = random_range(0,360);
		var xx = target.x + lengthdir_x(xo,xd); var yy = target.y + lengthdir_y(yo,yd);
		global.attackData = attackData;
		instance_create_depth(xx,yy,depth,obj_attack_multirand_prep);
	}
	//instance_change(obj_attack_aoe,1); 
	
	// start recovery
	// set recoveringLimbs at limbKey to the attackNumberInChain that is recovering
	var attackInChain = ds_map_find_value(owner.attackingLimbs,limbKey);
	ds_map_replace(owner.recoveringLimbs,limbKey,attackInChain);
		
	// set recoverFrames to -1
	ds_map_replace(owner.recoverFrames,limbKey,-1);
		
	// remove limbKey from attackingLimbs map
	ds_map_delete(owner.attackingLimbs,limbKey);
		
	owner.prevAttackHand = limbKey;
	instance_destroy(id,1);
	exit;
}

if attackData != noone && attackData.type == AttackTypes.Zone {
	global.attackData = attackData;
	instance_change(obj_attack_zone,1); exit;
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
	maskString = attackData.spriteName + "_attack_" + string(attackData.spriteAttackNumber) + "_" + string(attackData.spriteAttackNumberInChain) + "_mask";
}

// if this is a left hand attack, flip yscale 
if !(limbKey == "r" || (weapon != noone && weapon.isRanged && weapon.isTwoHanded)) && limbKey != noone {
	image_yscale = -1;
}
	
if asset_get_index(maskString) != -1 {
	sprite_index = asset_get_index(maskString);
}
else if !owner.hasHands {
	var sprStr = attackData.spriteName + "_wattack_" + string(attackData.spriteAttackNumber) + "_" + string(attackData.spriteAttackNumberInChain);
	sprite_index = asset_get_index(sprStr);
}
else {
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

	if weapon != noone && weapon.isTwoHanded && weapon.isRanged {
		ds_map_replace(owner.attackFrames,limbKey,0);
		//alarm[1] = 1;
		var attackInChain = ds_map_find_value(owner.attackingLimbs,limbKey);
		ds_map_replace(owner.recoveringLimbs,limbKey,attackInChain);
		
		// set recoverFrames to -1
		ds_map_replace(owner.recoverFrames,limbKey,-1);
		
		// remove limbKey from attackingLimbs map
		ds_map_delete(owner.attackingLimbs,limbKey);
	} else {
		// set recoveringLimbs at limbKey to the attackNumberInChain that is recovering
		var attackInChain = ds_map_find_value(owner.attackingLimbs,limbKey);
		ds_map_replace(owner.recoveringLimbs,limbKey,attackInChain);
		
		// set recoverFrames to -1
		ds_map_replace(owner.recoverFrames,limbKey,-1);
		
		// remove limbKey from attackingLimbs map
		ds_map_delete(owner.attackingLimbs,limbKey);
	}
		
	owner.prevAttackHand = limbKey;
} else {
	image_alpha = .5;
}


// special case -- guns create fire / smoke particles when attack starts
if weapon == noone || weapon == undefined exit;
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
	
	var xx = nx;
	var yy = ny;

	part_emitter_region(system,emitter,
		xx,xx,
		yy,yy,0,0);
	part_emitter_burst(system,emitter,particle,5);
	part_emitter_burst(system,emitter,particle2,2);
}

// ranged attacks may have particles 
if true {
	var wep = noone;
	// weapon or attack data, just need access to damages map
	if instance_exists(weapon) && weapon != noone {
		wep = weapon;
	} else wep = attackData;
	updateWeaponParticles(id);
}