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
isMelee = true;
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
direction = spread*global.projectileNumber;
facingDirection = direction;
speed = attackData.projectileSpeed;
/*
if part_type_exists(attackData.part1) {
	particle = attackData.part1;
}
if part_type_exists(attackData.part2) {
	particle = attackData.part2;
}





