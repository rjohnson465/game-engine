event_inherited();
name = "Krampus Mage";
descriptionChoices = ["Do not make him say 'Happy Holidays'", "Have a holly jolly Christmas, or else", "Ice Resistant"];
description = "Ice Resistant";
spriteName = "krampusmage";
spriteString = "enemy_krampusmage";
isFairy = true;
isFloating = true;

functionalSpeed = 5;
normalSpeed = 5;
turnSpeed = 10;
normalTurnSpeed = 10;

poiseCurrent = 10;
poiseMax = 10;

hasHands = true; // humanoid / uses hand attacks
currentAttackingHand = noone; // hide current attack hand default image when attacking with it

dyingParticleColor1 = [make_color_rgb(36,129,92), c_red];

// all weapons / shields enemy can use

var unarmed = makeEnemyWeapon(obj_hand_item_unarmed);

var iceshield = makeEnemyWeapon(obj_hand_item_iceshield);
var icewand = makeEnemyWeapon(obj_hand_item_wand_km, true);

ds_map_add(handItems,"lm1",icewand);
ds_map_add(handItems,"rm1",iceshield);
ds_map_add(handItems,"lr1",icewand);
ds_map_add(handItems,"rr1",iceshield);

ds_map_replace(equippedLimbItems,"l",iceshield);
ds_map_replace(equippedLimbItems,"r",icewand);
var rightHand = makeLimb(id,"r");
var leftHand = makeLimb(id,"l");

state = CombatantStates.Idle;

// stupidity is how many frames enemy will stay in thinking state
stupidity = 15; // default .5 second in thinking state
stupidityFrame = 0;

// general attacks info
meleeAggroRange = 150;
rangedAggroRange = 800;
farthestAllowedFromPost = 1500;
aggressiveness = 100; // aggressiveness 0-100%; every attackFrequencyFrames, roll using this number to see if we attack
attackFrequencyTotalFramesMelee = [30,45];
attackFrequencyTotalFramesRanged = [30,40];
strafeTotalFrames = [30,60];
waryDistanceRange=[100,120];
waryTotalFrames=[60,90];
skittishness = 100;
cautiousness = 0;

// melee attacks info
// currently chosen melee attack chain
currentMeleeAttack = noone;
// the minimum range for each melee attack chain (index 0 refers to attack chain 1, index 1 refers to attack chain 2...)
//meleeRangeArray=[15, 65, 65];

// ATTACKS
global.owner = id;

var icyHands = makeEnemyAttackObj(obj_attack_krampusmage_wand_1_1);
var iceAoe = makeEnemyAttackObj(obj_attack_krampusmage_wand_3_1);

var c0 = [icyHands];
var c1 = [iceAoe];
meleeAttacks = [c1, c0];
// ranged attacks info

// currently chosen ranged attack
currentRangedAttack = noone;

var iceMissile = makeEnemyAttackObj(obj_attack_krampusmage_wand_2_1);

var r0 = [iceMissile];

rangedAttacks = [r0, c1];


hp = 75;
maxHp = 75;

stamina = 60;
maxStamina = 60;
staminaRegen = 10;

beenHit = false; // hit during an attack animation
showHp = false; // hit at all (flag for showing health bar)

// stagger stuff
poise = 50;

// dodge stuff
agility = 60; // 0 - 100% chance to try a dodge
totalDodgeFrames = sprite_get_number(asset_get_index("spr_enemy_"+spriteName+"_dodge"));

ds_map_replace(defenses,MAGIC,40);
ds_map_replace(defenses,ICE,90);

soundsWhenHitVocals = [snd_enemy_krampuself_hit_1, snd_enemy_krampuself_hit_2];
soundsWhenDie = [snd_enemy_krampuself_die_1];

xpReward = 50;






