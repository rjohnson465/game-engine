event_inherited();
name = "No Eyed Deer";
descriptionChoices = ["Yeah I'd be pissed too if I didn't have eyes", "Insert funny text here"];
description = "Ugh";
spriteName = "noeyeddeer";
spriteString = "enemy_noeyeddeer";
isFairy = false;
isFloating = false;

functionalSpeed = 10;
normalSpeed = 10;
turnSpeed = 7;
normalTurnSpeed = turnSpeed;

dyingParticleColor1 = make_color_rgb(107,96,65)
dyingParticleColor2 = make_color_rgb(64,56,34)

canJump = false;

hasHands = false; // humanoid / uses hand attacks
currentAttackingHand = noone; // hide current attack hand default image when attacking with it

// general attacks info
meleeAggroRange = 300;
rangedAggroRange = 800;
farthestAllowedFromPost = 5000;
aggressiveness = 100; // aggressiveness 0-100%; every attackFrequencyFrames, roll using this number to see if we attack
attackFrequencyTotalFramesMelee = [10,25];
attackFrequencyTotalFramesRanged = [60,90];
strafeTotalFrames = [30,60];
waryDistanceRange=[100,120];
waryTotalFrames=[60,90];
skittishness = 100;
cautiousness = 50;

// melee attacks info
// the minimum range for each melee attack chain (index 0 refers to attack chain 1, index 1 refers to attack chain 2...)
meleeRangeArray=[];

// ATTACKS

// currently chosen melee attack chain
currentMeleeAttack = noone;
// the minimum range for each melee attack chain (index 0 refers to attack chain 1, index 1 refers to attack chain 2...)
//meleeRangeArray=[10,30,30,30,30];
//meleeRangeArray = [30];

// ATTACKS
/*
global.owner = id;
var bugBite = makeEnemyAttackObj(obj_attack_speyeder_head_1_1);

var webAoe = makeEnemyAttackObj(obj_attack_speyeder_aoe_1_1);

var claw1 = makeEnemyAttackObj(obj_attack_speyeder_claw_1_1);
var claw2 = makeEnemyAttackObj(obj_attack_speyeder_claw_1_2);

var poisonAttack = makeEnemyAttackObj(obj_attack_speyeder_poison_1_1);

var webAoeChain = [webAoe];
var meleeChain1 = [bugBite];
var meleeChain2 = [bugBite, webAoe];
var meleeChain3 = [claw1];
var meleeChain4 = [bugBite, claw1];
var doubleClawChain = [claw1,claw2];
var poisonAttackChain = [poisonAttack];
var jumpClaws = [bugBite,claw1,claw2];
meleeAttacks = [webAoeChain, meleeChain1, meleeChain3, meleeChain2, meleeChain4, doubleClawChain, jumpClaws, poisonAttackChain];

var c1 = makeEnemyAttackObj(obj_attack_noeyeddeer_passive_charge);
meleeAttacks = [c1]; */
alarm[4] = 7; // create passive attack obj every 15 frames

xpReward = 175;
hp = 200;
maxHp = 200;

stamina = 60;
maxStamina = 60;
staminaRegen = 10;

beenHit = false; // hit during an attack animation
showHp = false; // hit at all (flag for showing health bar)

// stagger stuff
poise = 100;

// dodge stuff
agility = 0; // 0 - 100% chance to try a dodge
totalDodgeFrames = sprite_get_number(asset_get_index("spr_enemy_"+spriteName+"_dodge"));

soundsWhenHitVocals = [snd_enemy_deer_hit1, snd_enemy_deer_hit2];
soundsWhenDie = [snd_enemy_deer_death];

runningDirection = image_angle;
usesDefaultIdleState = false;
usesDefaultMoveState = false;
staysOutOfEnemies = false;

canFlinch = false;

walkingSound = snd_walking_galloping;
audio_play_sound_on(walkingEmitter,walkingSound,1,1);