event_inherited();
name = "Abominable-Cursed Fairy";
descriptionChoices = ["Ice Resistant", "Took 'Chill out' too literally", "Doomed to become an Abominable Minion", "Cursed by Abominable Snowman magic", "Weak to fire"];
description = "Ice Resistant";
spriteName = "icecursedfairy";
spriteString = "enemy_icecursedfairy";
isFairy = true;
isFloating = true;

functionalSpeed = 5;
normalSpeed = 5;
turnSpeed = 10;
normalTurnSpeed = 10;

poiseCurrent = 20;
poiseMax = 20;

hasHands = true; // humanoid / uses hand attacks
currentAttackingHand = noone; // hide current attack hand default image when attacking with it

// all weapons / shields enemy can use
var torch = makeEnemyWeapon(obj_hand_item_torch);
var hatchet = makeEnemyWeapon(obj_hand_item_hatchet);
var tknife = makeEnemyWeapon(obj_hand_item_tknife);

ds_map_add(handItems,"lm1",hatchet);
ds_map_add(handItems,"rm1",torch);
ds_map_add(handItems, "lr1",tknife);
ds_map_add(handItems, "rr1", torch);

ds_map_replace(equippedLimbItems,"l",hatchet);
ds_map_replace(equippedLimbItems,"r",torch);
var rightHand = makeLimb(id,"r");
var leftHand = makeLimb(id,"l");

state = CombatantStates.Idle;

// stupidity is how many frames enemy will stay in thinking state
stupidity = 15; // default .5 second in thinking state
stupidityFrame = 0;

dyingParticleColor1 = C_HANDLES;
dyingParticleColor2 = c_aqua;

// general attacks info
meleeAggroRange = 300;
rangedAggroRange = 800;
farthestAllowedFromPost = 1000;
aggressiveness = 100; // aggressiveness 0-100%; every attackFrequencyFrames, roll using this number to see if we attack
attackFrequencyTotalFramesMelee = [20,45];
attackFrequencyTotalFramesRanged = [45,70];
strafeTotalFrames = [30,60];
waryDistanceRange=[100,120];
waryTotalFrames=[60,90];
skittishness = 100;
cautiousness = 50;

// melee attacks info
// currently chosen melee attack chain
currentMeleeAttack = noone;
// the minimum range for each melee attack chain (index 0 refers to attack chain 1, index 1 refers to attack chain 2...)
//meleeRangeArray=[15, 65, 65];

// ATTACKS
global.owner = id;

var torchSwing = makeEnemyAttackObj(obj_attack_icecursedfairy_torch_1_1);

var hatchet11 = makeEnemyAttackObj(obj_attack_icecursedfairy_hatchet_1_1);
var hatchet12 = makeEnemyAttackObj(obj_attack_icecursedfairy_hatchet_1_2);
var hatchet13 = makeEnemyAttackObj(obj_attack_icecursedfairy_hatchet_1_3);

var c0 = [torchSwing, hatchet11];
var c1 = [hatchet11, torchSwing];
var c2 = [hatchet11];
var c3 = [hatchet11, hatchet12];
var c4 = [hatchet11, hatchet12, hatchet13];

meleeAttacks = [c0, c1, c2, c3, c4];
// ranged attacks info

// currently chosen ranged attack
currentRangedAttack = noone;

var knifethrow = makeEnemyAttackObj(obj_attack_icecursedfairy_tknife_1_1);

var c0 = [knifethrow];
var c1 = [knifethrow, knifethrow];

rangedAttacks = [c0, c1];


hp = 100;
maxHp = 100;

stamina = 60;
maxStamina = 60;
staminaRegen = 10;

beenHit = false; // hit during an attack animation
showHp = false; // hit at all (flag for showing health bar)

// dodge stuff
agility = 33; // 0 - 100% chance to try a dodge
totalDodgeFrames = sprite_get_number(asset_get_index("spr_enemy_"+spriteName+"_dodge"));

ds_map_replace(defenses,ICE,50);
ds_map_replace(defenses,FIRE,-50);

soundsWhenHitVocals = [snd_enemy_unfairy_hit1, snd_enemy_unfairy_hit2];
soundsWhenDie = [snd_enemy_unfairy_die];

xpReward = 115;




