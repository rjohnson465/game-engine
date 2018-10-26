owner = global.owner;
life = 60;
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

visible = true;
var s = attackData.spriteName+"_"+string(attackData.spriteAttackNumber)+"_"+string(attackData.spriteAttackNumberInChain)+"_projectile";
sprite_index = asset_get_index(s);

var spread = 360 / attackData.numberOfProjectiles;
direction = ((spread*global.projectileNumber) + owner.facingDirection) mod 360;
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
		var rand = round(random_range(-1,array_length_1d(attackData.attackSoundsVocals)-1));
		if rand >= 0 {
			vocalsSound = attackData.attackSoundsVocals[rand];
			audio_play_sound_at(vocalsSound, owner.x, owner.y, owner.depth, 50, AUDIO_MAX_FALLOFF_DIST, 1, 0, 1);
		}
	}
}




