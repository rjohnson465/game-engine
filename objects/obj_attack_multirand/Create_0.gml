owner = global.owner;
life = 60;
depth = 1;
layer = owner.layer;
//x = owner.x;
//y = owner.y;
image_angle = owner.facingDirection;
originalDirection = owner.facingDirection;
facingDirection = owner.facingDirection;
weapon = noone;
//limbKey = global.limbKey; // l | r is most common
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

particle = attackData.part1;

if part_type_exists(attackData.part2) {
	particle2 = attackData.part2;
}

if attackData.mrAttackSound != noone && audio_exists(attackData.mrAttackSound) {
	audio_play_sound_at(attackData.mrAttackSound,x,y,depth,250,AUDIO_MAX_FALLOFF_DIST,1,0,1);
}






