event_inherited();
isShowingGrid = false;
name = "Abominable Minion";
descriptionChoices = ["Cursed to serve the Abominable Snowman", "Immune to ice attacks", "Creates icy zones"];
description = "Immune to ice attacks";
spriteName = "abominion";
spriteString = "enemy_abominion";
isFairy = false;
isFloating = true;

functionalSpeed = 6;
normalSpeed = 6;
turnSpeed = 6;
normalTurnSpeed = turnSpeed;


dyingParticleColor1 = c_silver;
dyingParticleColor2 = c_navy;

canJump = true;

hasHands = false; // humanoid / uses hand attacks
currentAttackingHand = noone; // hide current attack hand default image when attacking with it

// general attacks info
meleeAggroRange = 250;
rangedAggroRange = 800;
farthestAllowedFromPost = 1000;
aggressiveness = 100; // aggressiveness 0-100%; every attackFrequencyFrames, roll using this number to see if we attack
attackFrequencyTotalFramesMelee = [20,45];
attackFrequencyTotalFramesRanged = [60,90];
strafeTotalFrames = [30,60];
waryDistanceRange=[100,120];
waryTotalFrames=[60,90];
skittishness = 100;
cautiousness = 50;

poiseCurrent = 10000;
poiseMax = 10000;
poiseRegen = 100;
cannotStagger = true;

// melee attacks info
// the minimum range for each melee attack chain (index 0 refers to attack chain 1, index 1 refers to attack chain 2...)
meleeRangeArray=[];

xpReward = 125;

// ATTACKS

// currently chosen melee attack chain
currentMeleeAttack = noone;
// the minimum range for each melee attack chain (index 0 refers to attack chain 1, index 1 refers to attack chain 2...)
// ATTACKS


global.owner = id;
var frostburst = makeEnemyAttackObj(obj_attack_abominion_frostburst_1_1);
var crystalshot = makeEnemyAttackObj(obj_attack_abominion_crystalshot_1_1_melee);
var swing1 = makeEnemyAttackObj(obj_attack_abominion_swing_1_1);
var swing2 = makeEnemyAttackObj(obj_attack_abominion_swing_1_2);

var c0 = [frostburst];
var c1 = [crystalshot];
var c2 = [swing1];
var c3 = [swing1, swing2];
meleeAttacks = [c0, c1, c2, c3];

// ranged attacks info
var crystalshot = makeEnemyAttackObj(obj_attack_abominion_crystalshot_1_1);
var frostburst = makeEnemyAttackObj(obj_attack_abominion_frostburst_1_1_ranged);
var c0 = [crystalshot];
var c1 = [frostburst];
rangedAttacks = [c0, c1];


hp = 200;
maxHp = 200;
hpRegen = 0;

stamina = 60;
maxStamina = 60;
staminaRegen = 10;

beenHit = false; // hit during an attack animation
showHp = false; // hit at all (flag for showing health bar)

ds_map_replace(defenses, ICE, 100);
ds_map_replace(defenses, MAGIC, 50);
ds_map_replace(defenses, FIRE, -50);
ds_map_replace(defenses, POISON, 50);
ds_map_replace(defenses, LIGHTNING, -20);

// dodge stuff
agility = 0; // 0 - 100% chance to try a dodge
totalDodgeFrames = sprite_get_number(asset_get_index("spr_enemy_"+spriteName+"_dodge"));

soundsWhenHitVocals = [snd_vox_grunt_1, snd_vox_grunt_2];
soundsWhenDie = [snd_enemy_unfairy_die];
soundsWhenHit = [snd_hit_ice_1, snd_hit_ice_2, snd_hit_ice_3, snd_hit_ice_4];

chanceToDropHealthOrb = .3;


// constant emitter / ps for "spore" trails
sporeSystem = part_system_create();
sporeEmitter = part_emitter_create(sporeSystem);
// smoke
var smoke = part_type_create();
part_type_shape(smoke, pt_shape_smoke);
part_type_color2(smoke,make_color_rgb(61,92,129),c_silver);
part_type_orientation(smoke,0,0,0,15,1);
part_type_alpha3(smoke, .5, .25, .1);
part_type_size(smoke,0.2,0.5,0,0);
part_type_speed(smoke,.5,2,0,0);
part_type_direction(smoke,0,360,0,4);
part_type_life(smoke,45,60);
sporeParticle = smoke;

part_system_depth(sporeSystem, layer_get_depth(layer)+1);