event_inherited();
name = "Mushroom";
descriptionChoices = ["Devin pls pun"];
description = "Devin pls pun";
spriteName = "mushroom";
spriteString = "enemy_mushroom";
isFairy = false;
isFloating = false;

functionalSpeed = 10;
normalSpeed = 10;
turnSpeed = 10;
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
attackFrequencyTotalFramesRanged = [60,90];
strafeTotalFrames = [30,60];
waryDistanceRange=[100,120];
waryTotalFrames=[60,90];
skittishness = 100;
cautiousness = 50;

// melee attacks info
// the minimum range for each melee attack chain (index 0 refers to attack chain 1, index 1 refers to attack chain 2...)
meleeRangeArray=[];

xpReward = 200;

// ATTACKS

// currently chosen melee attack chain
currentMeleeAttack = noone;
// the minimum range for each melee attack chain (index 0 refers to attack chain 1, index 1 refers to attack chain 2...)

// ATTACKS
global.owner = id;
var spores = makeEnemyAttackObj(obj_attack_mushroom_spores_1_1);
var charge = makeEnemyAttackObj(obj_attack_mushroom_charge_1_1);

var sporesChain = [spores];
var chargeChain = [charge];
//meleeAttacks = [webAoeChain, meleeChain1, meleeChain3, meleeChain2, meleeChain4, doubleClawChain, jumpClaws, poisonAttackChain];
meleeAttacks = [sporesChain, chargeChain];

// ranged attacks info

// currently chosen ranged attack
//rangedRangeArray=[];
rangedAttacks = [sporesChain];

hp = 150;
maxHp = 150;
hpRegen = 1;

stamina = 60;
maxStamina = 60;
staminaRegen = 10;

beenHit = false; // hit during an attack animation
showHp = false; // hit at all (flag for showing health bar)

// stagger stuff
poise = 75;

ds_map_replace(defenses, FIRE, -100);

// dodge stuff
agility = 20; // 0 - 100% chance to try a dodge
totalDodgeFrames = sprite_get_number(asset_get_index("spr_enemy_"+spriteName+"_dodge"));

soundsWhenHitVocals = [snd_enemy_mushroom_hit1, snd_enemy_mushroom_hit2, snd_enemy_mushroom_hit3, snd_enemy_mushroom_hit4];
soundsWhenDie = [snd_enemy_mushroom_death1, snd_enemy_mushroom_death2];
