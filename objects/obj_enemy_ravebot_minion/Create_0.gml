event_inherited();
name = "Raver";
descriptionChoices = ["It's lit bro"];
description = "One bad cog and it all goes kablooey";
spriteName = "ravebot_minion";
spriteString = "enemy_ravebot_minion";
isFairy = false;
isFloating = true;

functionalSpeed = 0;
normalSpeed = 0;
turnSpeed = 0;
normalTurnSpeed = turnSpeed;

dyingParticleColor1 = make_color_rgb(103,95,78);
dyingParticleColor2 = c_ltgray;

canJump = false;

poiseCurrent = 18;
poiseMax = 18;

hasHands = false; // humanoid / uses hand attacks
currentAttackingHand = noone; // hide current attack hand default image when attacking with it

// general attacks info
meleeAggroRange = 1000;
rangedAggroRange = 5800;
farthestAllowedFromPost = 800;
aggressiveness = 100; // aggressiveness 0-100%; every attackFrequencyFrames, roll using this number to see if we attack
attackFrequencyTotalFramesMelee = [0,1];
attackFrequencyTotalFramesRanged = [60,90];
strafeTotalFrames = [25,50];
waryDistanceRange=[100,120];
waryTotalFrames=[60,90];
skittishness = 0;
cautiousness = 0;

// melee attacks info
// the minimum range for each melee attack chain (index 0 refers to attack chain 1, index 1 refers to attack chain 2...)
meleeRangeArray=[];

xpReward = 1;

sightAngleDelta = 360;

// ATTACKS

// currently chosen melee attack chain
currentMeleeAttack = noone;
// the minimum range for each melee attack chain (index 0 refers to attack chain 1, index 1 refers to attack chain 2...)

// ATTACKS
global.owner = id;

var laser = makeEnemyAttackObj(obj_attack_ravebot_minion_laser_1_1);

var lc = [laser];

meleeAttacks = [lc]; 

// ranged attacks info

// currently chosen ranged attack
rangedAttacks = [];

hp = 15;
maxHp = 15;
hpRegen = 1;

stamina = 60;
maxStamina = 60;
staminaRegen = 10;

beenHit = false; // hit during an attack animation
showHp = false; // hit at all (flag for showing health bar)

// stagger stuff
poise = 25;

ds_map_replace(defenses, MAGIC, -150);
ds_map_replace(defenses, ICE, -50);
ds_map_replace(defenses, FIRE, 0);
ds_map_replace(defenses, LIGHTNING, 50);
ds_map_replace(defenses, POISON, 100);
ds_map_replace(defenses, SLASH, 10);
ds_map_replace(defenses, PIERCE, 5);
ds_map_replace(defenses, CRUSH, 0);

// dodge stuff
agility = 0; // 0 - 100% chance to try a dodge
totalDodgeFrames = sprite_get_number(asset_get_index("spr_enemy_"+spriteName+"_dodge"));

soundsWhenHitVocals = [snd_enemy_gear_hit_1, snd_enemy_gear_hit_2, snd_enemy_gear_hit_3, snd_enemy_gear_hit_4];
soundsWhenDie = [snd_enemy_gear_death_1, snd_enemy_gear_death_2];

chanceToDropHealthOrb = .2;

walkingSound = noone;

cannotStagger = true;
randomize();
rotatingDir = random_range(0, 360);
image_index = random_range(0, image_number);


state = "Growing";
image_xscale = 0; image_yscale = 0;
image_alpha = 0;

summonParticle1 = part_type_create();
part_type_shape(summonParticle1, pt_shape_sphere);
part_type_alpha2(summonParticle1,.5,.1);
part_type_color2(summonParticle1,make_color_rgb(163,255,109),c_white);
part_type_size(summonParticle1,.05,.15,0,0);
part_type_speed(summonParticle1,.5,2,0,0);
part_type_direction(summonParticle1,0,360,0,4); // set later
part_type_orientation(summonParticle1,0,360,5,5,1);
part_type_life(summonParticle1,15,25);
summonParticle2 = part_type_create();
part_type_shape(summonParticle2, pt_shape_sphere);
part_type_alpha2(summonParticle2,.5,.1);
part_type_color2(summonParticle2,make_color_rgb(255,122,228),c_white);
part_type_size(summonParticle2,.05,.15,0,0);
part_type_speed(summonParticle2,.5,2,0,0);
part_type_direction(summonParticle2,0,360,0,4); // set later
part_type_orientation(summonParticle2,0,360,5,5,1);
part_type_life(summonParticle2,15,25);

summonPartSystem = part_system_create();
summonPartEmitter = part_emitter_create(summonPartSystem);

soundsWhenHit = [snd_metalhit1, snd_metalhit2]; // array of potential "hit" sounds (not "ahhs" or dialogue, just like metal in flesh, metal on metal...)