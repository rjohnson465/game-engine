owner = global.owner;
life = 60;
layer = owner.layer;
origLayer = layer;
depth = layer_get_depth(layer) - 1; // draw over owner
x = owner.x;
y = owner.y;
image_angle = owner.facingDirection;
originalDirection = owner.facingDirection;
facingDirection = owner.facingDirection;
weapon = noone;
limbKey = global.limbKey; // l | r is most common
isSpell = false;
isRanged = false; // probably not
isMelee = false;
attackData = noone;
combatantsHit = ds_list_create();
hasSetAlarm = false;
additionalDamages = ds_map_create();
spell = noone;
particle = noone;
particle2 = noone;
spellElement = noone;
percentCharged = 1;
system = part_system_create();
part_system_depth(system,layer_get_depth(owner.layer));
emitter = part_emitter_create(system);
soundEmitter = audio_emitter_create();
sound = noone;
isSoundLooping = false;
isOnFire = false;

attackData = global.attackData;
attackNumber = attackData.spriteAttackNumber-1;
attackNumberInChain = attackData.spriteAttackNumberInChain;

aoeOnlyHitsOnce = true;
if attackData != noone && attackData.aoeOnlyHitsOnce != noone {
	aoeOnlyHitsOnce = attackData.aoeOnlyHitsOnce;
}

isTracking = false;
if attackData != noone && attackData.tracksTargets {
	isTracking = true;
}

visible = true;
var s = attackData.spriteName+"_"+string(attackData.spriteAttackNumber)+"_"+string(attackData.spriteAttackNumberInChain)+"_projectile";
sprite_index = asset_get_index(s);

if attackData.aoeProjectilesDirectionOffsetArray == noone || !is_array(attackData.aoeProjectilesDirectionOffsetArray) {
	var spread = attackData.spreadTotal / attackData.numberOfProjectiles;
	direction = (((spread*global.projectileNumber) + owner.facingDirection) + attackData.aoeStartOffset); // mod attackData.spreadTotal;
}
// if aoeProjectilesDirectionOffsetArray is supplied, use that for direction
else {
	direction = owner.facingDirection + attackData.aoeProjectilesDirectionOffsetArray[global.projectileNumber];
}
facingDirection = direction;
speed = attackData.projectileSpeed;

if part_type_exists(attackData.part1) {
	particle = attackData.part1;
	part_type_direction(particle,direction-45, direction+45, 0, 5);
}
if part_type_exists(attackData.part2) {
	particle = attackData.part2;
}

if attackData != noone {
	var vocalsSound = noone;
	if array_length_1d(attackData.attackSoundsVocals) != 0 {
		randomize();
		var lBound = attackData.mustVocalizeAttack ? 0 : -1;
		var rand = round(random_range(lBound,array_length_1d(attackData.attackSoundsVocals)-1));
		if rand >= 0 {
			vocalsSound = attackData.attackSoundsVocals[rand];
			audio_play_sound_at(vocalsSound, owner.x, owner.y, owner.depth, 500, AUDIO_MAX_FALLOFF_DIST, 1, 0, 1);
		}
	}
	
	isSpell = attackData.isSpell;
}


if attackData != noone && attackData.hasLightRadius {
	var lr_scale = attackData.lightRadiusScale;
	var lr_color = attackData.lightRadiusColor;
	var lr_alpha = attackData.lightRadiusAlpha;
	if lr_alpha == noone {
		var fNum = getLayerFloorNumber(owner.layer);
		lr_alpha = calculateLightRadiusAlphaLayer(fNum);
	}
	var lr_spr = attackData.lightRadiusSprite;
	if attackData.lightRadiusScaleX == noone || attackData.lightRadiusScaleY == noone {
		light_create_layer(lr_spr, lr_scale, lr_color, lr_alpha, owner.facingDirection, true);
	}
	else {
		var xs = attackData.lightRadiusScaleX;
		var ys = attackData.lightRadiusScaleY;
		light_create_layer_multiscale(lr_spr, xs, ys, lr_color, lr_alpha, owner.facingDirection, true)
	}	
}

/*
// if touching a solid environment on create, destroy immediately 
with obj_solid_environment {
	if distance_to_object(other) < 5 {
		other.alarm[0] = 30;
		other.hasSetAlarm = true;
	}
}

