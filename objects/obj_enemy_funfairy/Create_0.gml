event_inherited();
name = "Funfairy";
descriptionChoices = ["Are we having fun yet?", "Watch out for his rubber chicken", "Cream pie enthusiast"];
description = "Watch out for his rubber chicken";
spriteName = "funfairy";
spriteString = "enemy_funfairy";
isFairy = true;
isFloating = true;
isBoss = true;

functionalSpeed = 6;
normalSpeed = 6;
turnSpeed = 15;
normalTurnSpeed = 15;

hasHands = true; // humanoid / uses hand attacks
currentAttackingHand = noone; // hide current attack hand default image when attacking with it

// all weapons / shields enemy can use
var unarmed = makeEnemyWeapon(obj_hand_item_unarmed);
var toyhammer = makeEnemyWeapon(obj_hand_item_toyhammer);
ds_map_replace(handItems,"lm1",toyhammer);
ds_map_replace(handItems,"rm1",unarmed);
ds_map_replace(handItems,"lr1",noone);
ds_map_replace(handItems,"rr1",noone);
rangedRangeArray = []; rangedAttacks = [];
ds_map_replace(equippedLimbItems,"l",toyhammer);
ds_map_replace(equippedLimbItems,"r",unarmed);


ds_map_replace(equippedLimbItems,"l",unarmed);
ds_map_replace(equippedLimbItems,"r",toyhammer);
var rightHand = makeLimb(id,"r");
var leftHand = makeLimb(id,"l");

state = CombatantStates.Idle;

// general attacks info
meleeAggroRange = 800;
rangedAggroRange = 800;
farthestAllowedFromPost = 1000;
aggressiveness = 100; // aggressiveness 0-100%; every attackFrequencyFrames, roll using this number to see if we attack
attackFrequencyTotalFramesMelee = [30,60];
attackFrequencyTotalFramesRanged = [45,70];
strafeTotalFrames = [30,60];
waryDistanceRange=[500,600];
waryTotalFrames=[60,90];
waryCheckTotalFrames = [150,300];
waryCheckFrame = 150;
skittishness = 75;
cautiousness = 50;
jumpSpeedFactor = 4;

dyingParticleColor1 = [c_red, c_orange, c_yellow, c_lime, c_blue, c_purple];

// melee attacks info
// currently chosen melee attack chain
currentMeleeAttack = noone;
// the minimum range for each melee attack chain (index 0 refers to attack chain 1, index 1 refers to attack chain 2...)
//meleeRangeArray=[15, 65, 65];

// ATTACKS
global.owner = id;

var hammerSwing = makeEnemyAttackObj(obj_attack_funfairy_toyhammer_1_1);

var hammerTwirl1 = makeEnemyAttackObj(obj_attack_funfairy_toyhammer_2_1);
var hammerTwirl2 = makeEnemyAttackObj(obj_attack_funfairy_toyhammer_2_2);

var c0 = [hammerSwing];
var c1 = [hammerTwirl1, hammerTwirl2];
var c2 = [hammerSwing, hammerTwirl2];
meleeAttacks = [c0, c1, c2];
// ranged attacks info

// currently chosen ranged attack
currentRangedAttack = noone;
rangedAttacks = [];

hp = 300;
maxHp = 300;

stamina = 60;
maxStamina = 60;
staminaRegen = 10;

beenHit = false; // hit during an attack animation
showHp = false; // hit at all (flag for showing health bar)

// stagger stuff
poise = 100;

// dodge stuff
agility = 100; // 0 - 100% chance to try a dodge
totalDodgeFrames = sprite_get_number(asset_get_index("spr_enemy_"+spriteName+"_dodge"));

ds_map_replace(defenses,MAGIC,50);

soundsWhenHitVocals = [snd_enemy_funfairy_hit_1, snd_enemy_funfairy_hit_2];
soundsWhenDie = [snd_enemy_funfairy_death];

chanceToDropHealthOrb = 1;
xpReward = 1000;
