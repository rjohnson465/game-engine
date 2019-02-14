event_inherited();

isShowingLightRadius = true;
lightRadiusScale = .3;

// this is pretty stupid, but find your light radius, destroy it, remake it so light radius is made on create
var lr = noone;
with obj_light_radius {
	if owner == other {
		lr = id;
	}
}
if (lr != noone) {
	light_destroy_layer(getLayerFloorNumber(layer),lr);
	instance_destroy(lr);
	global.makeLightOnCreate = true; 
	global.owner = id;
	instance_create_depth(x,y,depth,obj_light_radius);
}

name = "Spore";
descriptionChoices = ["Ugh babies am i right", "EWWWWWWWW"];
description = "Ugh babies am i right";
spriteName = "spore";
spriteString = "enemy_spore";
isFairy = false;
isFloating = false;

sightAngleDelta = 360;

// spore specific
doesEnemyRespawn = false;
randomize();
sporeDirection = random_range(0,360);
sporeIsInactive = true;
// how long spore is "inactive" and shooting for
sporeTimer = random_range(25,45);
// constant emitter / ps for "spore" trails
sporeSystem = part_system_create();
sporeEmitter = part_emitter_create(sporeSystem);
sporeParticle = part_type_create();
part_type_shape(sporeParticle, pt_shape_sphere);
part_type_alpha2(sporeParticle,1,.2);
part_type_color2(sporeParticle,c_olive,c_white);
part_type_size(sporeParticle,.03,.10,0,0);
part_type_speed(sporeParticle,.5,2,0,0);
part_type_direction(sporeParticle,0,360,0,4); // set later
part_type_orientation(sporeParticle,0,360,5,5,1);
part_type_life(sporeParticle,15,25);

part_system_depth(sporeSystem, layer_get_depth(layer)+1);

// while "inactive", a spore can hit the player every 10 frames for decent poison damage
alarm[4] = random_range(0,10); 
if (global.player.lockOnTarget == id) {
	global.player.lockOnTarget = noone;
}
isInvulnerable = true; // becomes vulnerable once active

functionalSpeed = 6;
normalSpeed = 6;
turnSpeed = 6;
normalTurnSpeed = turnSpeed;

dyingParticleColor1 = make_color_rgb(156,69,22)
dyingParticleColor2 = make_color_rgb(246,220,206)

canJump = false;

hasHands = false; // humanoid / uses hand attacks
currentAttackingHand = noone; // hide current attack hand default image when attacking with it

// general attacks info
meleeAggroRange = 300;
rangedAggroRange = 800;
farthestAllowedFromPost = 5000;
aggressiveness = 100; // aggressiveness 0-100%; every attackFrequencyFrames, roll using this number to see if we attack
attackFrequencyTotalFramesMelee = [30,50];
attackFrequencyTotalFramesRanged = [80,120];
strafeTotalFrames = [30,60];
waryDistanceRange=[100,120];
waryTotalFrames=[60,90];
skittishness = 100;
cautiousness = 50;

// melee attacks info
// the minimum range for each melee attack chain (index 0 refers to attack chain 1, index 1 refers to attack chain 2...)
meleeRangeArray=[];

xpReward = 50;

// ATTACKS

// currently chosen melee attack chain
currentMeleeAttack = noone;
// the minimum range for each melee attack chain (index 0 refers to attack chain 1, index 1 refers to attack chain 2...)
meleeRangeArray = [];
meleeAggroRange = noone;
meleeAttacks = [];

// ranged attacks info

// currently chosen ranged attack
global.owner = id;
var hit = makeEnemyAttackObj(obj_attack_spore_hit_1_1);
var hitChain = [hit];
rangedRangeArray=[10];
rangedAttacks = [hitChain];
rangedAggroRange = 10000;

hp = 10;
maxHp = 10;
hpRegen = 5;

stamina = 60;
maxStamina = 60;
staminaRegen = 10;

beenHit = false; // hit during an attack animation
showHp = false; // hit at all (flag for showing health bar)

// stagger stuff
poise = 0;

// dodge stuff
agility = 0; // 0 - 100% chance to try a dodge
totalDodgeFrames = sprite_get_number(asset_get_index("spr_enemy_"+spriteName+"_dodge"));

soundsWhenHitVocals = [snd_enemy_mushroom_hit1, snd_enemy_mushroom_hit2, snd_enemy_mushroom_hit3, snd_enemy_mushroom_hit4];
soundsWhenDie = [snd_enemy_mushroom_death1, snd_enemy_mushroom_death2];
