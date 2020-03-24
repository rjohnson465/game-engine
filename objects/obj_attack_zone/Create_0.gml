owner = global.owner;
life = 600;
depth = 1;
layer = owner.layer;
origLayer = layer;
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
part_system_depth(system, layer_get_depth(owner.layer)-1);
emitter = part_emitter_create(system);
soundEmitter = audio_emitter_create();
sound = noone;
isSoundLooping = false;
isOnFire = false;
isDestroying = false;

attackData = global.attackData;
attackNumber = attackData.spriteAttackNumber-1;
attackNumberInChain = attackData.spriteAttackNumberInChain;

visible = attackData.isVisible;
var s = attackData.spriteName+"_"+string(attackData.spriteAttackNumber)+"_"+string(attackData.spriteAttackNumberInChain)+"_zone";
sprite_index = asset_get_index(s);

if limbKey == "l" {
	image_yscale = -1;
}

facingDirection = owner.facingDirection;
alarm[2] = attackData.refreshCombatantsHit;

if part_type_exists(attackData.part1) {
	particle = attackData.part1;
	part_type_direction(particle,facingDirection-45, facingDirection+45, 0, 5);
}
if part_type_exists(attackData.part2) {
	particle2 = attackData.part2;
}

audio_play_sound_at(attackData.attackSound, owner.x,owner.y,owner.depth, 50, AUDIO_MAX_FALLOFF_DIST, 1, 0, 1);

sndEmitter = audio_emitter_create();
audio_emitter_gain(sndEmitter,1);
audio_emitter_position(sndEmitter, owner.x, owner.y, owner.depth);
audio_emitter_falloff(sndEmitter, 50, AUDIO_MAX_FALLOFF_DIST, 1);
sndEmitterSndId = audio_play_sound_on(sndEmitter, attackData.attackSoundLoop, 1, 1);

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
}

// maybe make light
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
