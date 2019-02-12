event_inherited();
name = "Troll";
descriptionChoices = ["Devin pls pun"];
description = "Devin pls pun";
spriteName = "troll";
spriteString = "enemy_troll";
isFairy = false;
isFloating = false;

functionalSpeed = 7;
normalSpeed = 7;
turnSpeed = 10;
normalTurnSpeed = turnSpeed;

dyingParticleColor1 = make_color_rgb(79,48,86)
dyingParticleColor2 = make_color_rgb(39,30,41)

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
cautiousness = 100;

xpReward = 400;

var staff = makeEnemyWeapon(obj_hand_item_trollstaff);
var spikedshield = makeEnemyWeapon(obj_hand_item_spikedshield);
//var longsword = makeEnemyWeapon(obj_hand_item_longsword);
//var shortbow = makeEnemyWeapon(obj_hand_item_shortbow);
ds_map_add(handItems,"lm1",spikedshield);
ds_map_add(handItems,"rm1",staff);
//ds_map_add(handItems, "lr1",noone);
//ds_map_add(handItems, "rr1", noone);

ds_map_replace(equippedLimbItems,"l",staff);
ds_map_replace(equippedLimbItems,"r",spikedshield);

var rightWep = makeLimblessWeapon(id,"r");
var leftWep = makeLimblessWeapon(id,"l");
//var rightHand = makeLimb(id,"r", true);
//var leftHand = makeLimb(id,"l", true);

// ATTACKS

// currently chosen melee attack chain
currentMeleeAttack = noone;
// the minimum range for each melee attack chain (index 0 refers to attack chain 1, index 1 refers to attack chain 2...)
//meleeRangeArray=[10,30,30,30,30];
//meleeRangeArray = [30];

// ATTACKS
global.owner = id;
var staffSwing1 = makeEnemyAttackObj(obj_attack_troll_staff_1_1);

var c0 = [staffSwing1];
//meleeAttacks = [webAoeChain, meleeChain1, meleeChain3, meleeChain2, meleeChain4, doubleClawChain, jumpClaws, poisonAttackChain];
meleeAttacks = [c0];

// ranged attacks info

// currently chosen ranged attack
rangedRangeArray=[];
rangedAttacks = [];

hp = 225;
maxHp = 225;
hpRegen = 5;

stamina = 60;
maxStamina = 60;
staminaRegen = 10;

beenHit = false; // hit during an attack animation
showHp = false; // hit at all (flag for showing health bar)

// stagger stuff
poise = 90;

ds_map_replace(defenses, FIRE, -100);

// dodge stuff
agility = 0; // 0 - 100% chance to try a dodge
totalDodgeFrames = sprite_get_number(asset_get_index("spr_enemy_"+spriteName+"_dodge"));

//audio_play_sound_on(walkingEmitter,snd_walking_heavy,1,1);
walkingSound = snd_walking_heavy;

//soundsWhenHitVocals = [snd_enemy_mushroom_hit1, snd_enemy_mushroom_hit2, snd_enemy_mushroom_hit3, snd_enemy_mushroom_hit4];
soundsWhenDie = [snd_enemy_troll_death1];

// override grid for this big boi 
/*
mp_grid_destroy(personalGrid); personalGrid = -1;
var cell_width = 45;//bbox_right-bbox_left;
var cell_height = 45; //bbox_bottom-bbox_top;

var hcells = room_width div cell_width;
var vcells = room_height div cell_height;
personalGrid = mp_grid_create(0,0,hcells,vcells,cell_width, cell_height);