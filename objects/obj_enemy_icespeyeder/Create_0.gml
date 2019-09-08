event_inherited();
isShowingGrid = false;
name = "Ice Speyeder";
descriptionChoices = ["Way too many eyes", "KILL IT WITH FIRE (Seriously try that)", "Wow what a great pun", "This bug is chill"];
description = "Way too many eyes";
spriteName = "icespeyeder";
spriteString = "enemy_icespeyeder";
isFairy = false;
isFloating = false;

functionalSpeed = 7;
normalSpeed = 7;
turnSpeed = 7;
normalTurnSpeed = turnSpeed;

dyingParticleColor1 = make_color_rgb(178,224,244)
dyingParticleColor2 = make_color_rgb(19,38,52)

canJump = false;

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

poiseCurrent = 45;
poiseMax = 45;

// melee attacks info
// the minimum range for each melee attack chain (index 0 refers to attack chain 1, index 1 refers to attack chain 2...)
meleeRangeArray=[];

xpReward = 105;

// ATTACKS

// currently chosen melee attack chain
currentMeleeAttack = noone;
// the minimum range for each melee attack chain (index 0 refers to attack chain 1, index 1 refers to attack chain 2...)
// ATTACKS


global.owner = id;
var bugBite = makeEnemyAttackObj(obj_attack_icespeyeder_head_1_1);

var webAoe = makeEnemyAttackObj(obj_attack_icespeyeder_aoe_1_1);

var claw1 = makeEnemyAttackObj(obj_attack_icespeyeder_claw_1_1);
var claw2 = makeEnemyAttackObj(obj_attack_icespeyeder_claw_1_2);

var iceAttack = makeEnemyAttackObj(obj_attack_icespeyeder_ice_1_1);

var webAoeChain = [webAoe];
var meleeChain1 = [bugBite];
var meleeChain2 = [bugBite, webAoe];
var meleeChain3 = [claw1];
var meleeChain4 = [bugBite, claw1];
var doubleClawChain = [claw1,claw2];
var iceAttackChain = [iceAttack];
var jumpClaws = [bugBite,claw1,claw2];
meleeAttacks = [webAoeChain, meleeChain1, meleeChain3, meleeChain2, meleeChain4, doubleClawChain, jumpClaws, iceAttackChain];
//meleeAttacks = [iceAttackChain];

// ranged attacks info

// currently chosen ranged attack
var webShot = makeEnemyAttackObj(obj_attack_icespeyeder_webshot_1_1);
var webShotChain = [webShot];
rangedAttacks = [webShotChain];


hp = 125;
maxHp = 125;
hpRegen = 1;

stamina = 60;
maxStamina = 60;
staminaRegen = 10;

beenHit = false; // hit during an attack animation
showHp = false; // hit at all (flag for showing health bar)

ds_map_replace(defenses, FIRE, -100);

// dodge stuff
agility = 20; // 0 - 100% chance to try a dodge
totalDodgeFrames = sprite_get_number(asset_get_index("spr_enemy_"+spriteName+"_dodge"));

soundsWhenHitVocals = [snd_enemy_speyeder_hit_1, snd_enemy_speyeder_hit_2];
soundsWhenDie = [snd_enemy_speyeder_death];
