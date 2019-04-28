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

canIntersectWithAllies = true;

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

// create passive attack obj every 3 frames
damageFrequency = 3;
alarm[4] = damageFrequency; 


xpReward = 150;
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
walkingSoundIndex = audio_play_sound_on(walkingEmitter,walkingSound,1,1);