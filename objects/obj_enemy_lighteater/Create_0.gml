event_inherited();
name = "Lighteater";
descriptionChoices = ["Are we having fun yet?", "Watch out for his rubber chicken", "Cream pie enthusiast"];
description = "Watch out for his rubber chicken";
spriteName = "lighteater";
spriteString = "enemy_lighteater";
isFairy = false;
isFloating = false;
isBoss = true;

functionalSpeed = 6;
normalSpeed = 6;
turnSpeed = 15;
normalTurnSpeed = 15;

hasHands = false; // humanoid / uses hand attacks
currentAttackingHand = noone; // hide current attack hand default image when attacking with it

lamplightsEatenCount = 0; // special; will drop this many lamplights on death

// if health is below 50%, every 20-40 seconds, the lighteater will try to heal himself
// by going to a light and consuming it, if any light source exists
alarm[2] = -4;
HUNGER_FRAME_MIN = 60; // 20 seconds
HUNGER_FRAME_MAX = 120; // 40 seconds
lamplightToEat = noone;
lamplightEatFrame = 15;

// all weapons / shields enemy can use
/*
var unarmed = makeEnemyWeapon(obj_hand_item_unarmed);
var toyhammer = makeEnemyWeapon(obj_hand_item_toyhammer);
var pie = makeEnemyWeapon(obj_hand_item_pie);
ds_map_replace(handItems,"lm1",toyhammer);
ds_map_replace(handItems,"rm1",unarmed);
ds_map_replace(handItems,"lm2",pie);
ds_map_replace(handItems,"rm2",unarmed);
ds_map_replace(handItems,"lr1",noone);
ds_map_replace(handItems,"rr1",noone);
rangedRangeArray = []; rangedAttacks = [];
ds_map_replace(equippedLimbItems,"l",toyhammer);
ds_map_replace(equippedLimbItems,"r",unarmed);


ds_map_replace(equippedLimbItems,"l",unarmed);
ds_map_replace(equippedLimbItems,"r",toyhammer);
var rightHand = makeLimb(id,"r");
var leftHand = makeLimb(id,"l"); */

state = CombatantStates.Idle;

// general attacks info
meleeAggroRange = 800;
rangedAggroRange = 800;
farthestAllowedFromPost = 1000;
aggressiveness = 0; // aggressiveness 0-100%; every attackFrequencyFrames, roll using this number to see if we attack
attackFrequencyTotalFramesMelee = [30,90];
attackFrequencyTotalFramesRanged = [45,70];
strafeTotalFrames = [30,60];
waryDistanceRange=[500,600];
waryTotalFrames=[60,90];
waryCheckTotalFrames = [150,300];
waryCheckFrame = 150;
skittishness = 75;
cautiousness = 50;
jumpSpeedFactor = 4;

dyingParticleColor1 = [make_color_rgb(143, 154, 136), make_color_rgb(87,96,80), make_color_rgb(100, 111, 77)];

// melee attacks info
// currently chosen melee attack chain
currentMeleeAttack = noone;
// the minimum range for each melee attack chain (index 0 refers to attack chain 1, index 1 refers to attack chain 2...)
//meleeRangeArray=[15, 65, 65];

// ATTACKS
global.owner = id;

meleeAttacks = [];
var hammerSwing = makeEnemyAttackObj(obj_attack_funfairy_toyhammer_1_1);

var hammerTwirl1 = makeEnemyAttackObj(obj_attack_funfairy_toyhammer_2_1);
var hammerTwirl2 = makeEnemyAttackObj(obj_attack_funfairy_toyhammer_2_2);

var magicmissile = makeEnemyAttackObj(obj_attack_funfairy_toyhammer_3_1);

var hammerCharge = makeEnemyAttackObj(obj_attack_funfairy_toyhammer_4_1);

var pieThrow = makeEnemyAttackObj(obj_attack_funfairy_pie_1_1);

var c0 = [hammerSwing];
var c1 = [hammerTwirl1, hammerTwirl2];
var c2 = [hammerSwing, hammerTwirl2];
var c3 = [magicmissile];
var c4 = [pieThrow];
var c5 = [hammerSwing, pieThrow];
var c6 = [pieThrow, hammerSwing];
var c7 = [hammerCharge];
var c8 = [hammerSwing, hammerCharge];
meleeAttacks = [c0, c1, c2, c3, c3, c4, c5, c6, c7, c8];
// ranged attacks info

// currently chosen ranged attack
currentRangedAttack = noone;
rangedAttacks = [];

hp = 25;
maxHp = 25;

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

ds_map_replace(defenses,PIERCE,10);
ds_map_replace(defenses,SLASH,7);

soundsWhenHitVocals = [];
soundsWhenDie = [];

chanceToDropHealthOrb = 1;
xpReward = 1500;
