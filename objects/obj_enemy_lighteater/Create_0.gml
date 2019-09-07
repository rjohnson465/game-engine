event_inherited();
name = "Lighteater";
descriptionChoices = ["Are we having fun yet?", "Watch out for his rubber chicken", "Cream pie enthusiast"];
description = "Watch out for his rubber chicken";
spriteName = "lighteater";
spriteString = "enemy_lighteater";
isFairy = false;
isFloating = false;
isBoss = true;

functionalSpeed = 7;
normalSpeed = 7;
turnSpeed = 10;
normalTurnSpeed = 10;

cannotStagger = true;

hasHands = false; // humanoid / uses hand attacks
currentAttackingHand = noone; // hide current attack hand default image when attacking with it

lamplightsEatenCount = 0; // special; will drop this many lamplights on death

// if health is below 50%, every 20-40 seconds, the lighteater will try to heal himself
// by going to a light and consuming it, if any light source exists
alarm[2] = -4;
HUNGER_FRAME_MIN = 150; // 5 seconds
HUNGER_FRAME_MAX = 300; // 10 seconds

// if lighteaters takes this much damage while eating, he staggers out of eat phase
stopEatingDamageMax = 40;
stopEatingDamage = 0;
stopEatingDamageAttacksList = ds_list_create();

lamplightToEat = noone;
LAMPLIGHT_EAT_FRAME_MAX = 90;
LAMPLIGHT_TOTAL_HEAL_AMOUNT = 100;
lamplightEatFrame = LAMPLIGHT_EAT_FRAME_MAX;

partSystemLighteater = part_system_create();
part_system_depth(partSystemLighteater, depth);
partEmiLighteater = part_emitter_create(partSystemLighteater);
partLamplightHeal = noone;
var magic = part_type_create();
part_type_shape(magic, pt_shape_sphere);
part_type_color2(magic,c_aqua,c_ltgray);
part_type_orientation(magic,0,0,0,15,1);
part_type_size(magic,0,0.08,0,0);
part_type_speed(magic,2,8,0,0);
part_type_direction(magic,0,360,0,4);
part_type_life(magic,10,15);
partLamplightHeal = magic;


state = CombatantStates.Idle;

// general attacks info
meleeAggroRange = 800;
rangedAggroRange = 800;
farthestAllowedFromPost = 1000;
aggressiveness = 100; // aggressiveness 0-100%; every attackFrequencyFrames, roll using this number to see if we attack
attackFrequencyTotalFramesMelee = [25,45];
attackFrequencyTotalFramesRanged = [25,30];
strafeTotalFrames = [30,60];
waryDistanceRange=[500,600];
waryTotalFrames=[60,90];
waryCheckTotalFrames = [150,300];
waryCheckFrame = 150;
skittishness = 90;

jumpSpeedFactor = 3;

dyingParticleColor1 = [make_color_rgb(143, 154, 136), make_color_rgb(87,96,80), make_color_rgb(100, 111, 77)];

// melee attacks info
// currently chosen melee attack chain
currentMeleeAttack = noone;
// the minimum range for each melee attack chain (index 0 refers to attack chain 1, index 1 refers to attack chain 2...)
//meleeRangeArray=[15, 65, 65];

// ATTACKS
global.owner = id;
var breath = makeEnemyAttackObj(obj_attack_lighteater_breath_1_1);
var aoe = makeEnemyAttackObj(obj_attack_lighteater_aoe_1_1);

var cs1 = makeEnemyAttackObj(obj_attack_lighteater_claw_1_1);
var cs2 = makeEnemyAttackObj(obj_attack_lighteater_claw_1_2);

var cjab = makeEnemyAttackObj(obj_attack_lighteater_claw_2_1);
var csweep = makeEnemyAttackObj(obj_attack_lighteater_claw_2_2);

var tailshot = makeEnemyAttackObj(obj_attack_lighteater_tail_1_1);
var tailstab = makeEnemyAttackObj(obj_attack_lighteater_tail_2_1);

var c_jab = [cjab];
var c_js = [cjab, csweep];

var c_ts = [tailshot];
var c_tailstab = [tailstab];

var c_breath = [breath];
var c_aoe = [aoe];
var c_claw2 = [cs1, cs2];
var c_claw3 = [cs1, cs2, cjab];
var c_claw4hit = [cs1, cs2, cjab, csweep];

var c_clawsTail = [cs1, cs2, tailstab];
var c_clawsTail2 = [cs1, cs2, tailshot];
var c_aoeSweep = [aoe, csweep];

meleeAttacks = [
	c_js, c_jab, c_claw4hit, c_claw2, c_claw3, c_breath, c_clawsTail, 
	c_aoe, c_aoeSweep, c_clawsTail2, c_ts, c_tailstab
];

// meleeAttacks = [c_aoe, c_breath];
// ranged attacks info

// currently chosen ranged attack
currentRangedAttack = noone;
rangedAttacks = [];

hp = 450;
maxHp = 450;

stamina = 6000;
maxStamina = 6000;
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

soundsWhenHitVocals = [snd_enemy_speyeder_hit_1, snd_enemy_speyeder_hit_2];
soundsWhenDie = [snd_enemy_lighteater_death];

walkingSound = snd_enemy_lighteater_walk;

chanceToDropHealthOrb = 1;
xpReward = 1500;

doTriggerTonyIntro = false;
doSpawnTony = false;

hasCalculatedPathToLamplight = false;