
// use macros for elements rather than enums (helps with sprite getting)
#macro PHYSICAL "physical"
#macro SLASH "slash"
#macro PIERCE "pierce"
#macro CRUSH "crush"
#macro MAGIC "magic"
#macro FIRE "fire"
#macro ICE "ice"
#macro POISON "poison"
#macro LIGHTNING "lightning"

global.ALL_ELEMENTS = [MAGIC,FIRE,ICE,POISON,LIGHTNING];
global.ALL_DAMAGE_TYPES = [PHYSICAL,SLASH,PIERCE,CRUSH,MAGIC,FIRE,ICE,POISON,LIGHTNING];
playerLightRadius = noone;

event_inherited();
global.player = id;
functionalSpeed = 6;
normalSpeed = 6;
facingDirection = 0;

spriteType = "player";
spriteString = "player";
isFairy = true;
type = CombatantTypes.Player;

// gui
isMouseInMenu = false;
instance_create_depth(x,y,1,obj_player_gui);

enum EquipmentSlots {
	Head,
	LeftHand1,
	LeftHand2,
	RightHand1,
	RightHand2,
	LeftRing1,
	LeftRing2,
	RightRing1,
	RightRing2
}

// grow hands 
hasHands = true; 

unarmed = instance_create_depth(x,y,1,obj_hand_item_unarmed);
unarmed.persistent = true;

equippedItems = ds_list_create();

ds_map_replace(equippedLimbItems,"r",unarmed);
ds_map_replace(equippedLimbItems,"l",unarmed);
ds_map_replace(equippedLimbItems,"l2",unarmed);
ds_map_replace(equippedLimbItems,"r2",unarmed);

var rightHand = makeLimb(id,"r");
var leftHand = makeLimb(id,"l");

// attack states
// <limb><bool> kvp's
attackAgain = ds_map_create();
ds_map_replace(attackAgain,"r",false);
ds_map_replace(attackAgain,"l",false);
isReadyToFire = false; // ranged only boolean

comboTimeQuantum = 60; // 60 frames for a move to count as part of a combo
comboNumber = 0; // number of hits landed in combo
comboEffectiveNumber = 0; // used to determine the comboModeLevel
comboHitsToNextLevel = 4;
comboModeLevel = 0;
comboModeTotalFrames = 120; // default 4 seconds in current combo mode
comboModeFrame = 0;
comboFrame = 0; // counts up to COMBO_TIME_QUANTUM -- if it gets there, combo level ends

// dodge stuff
dodgeDirection = noone;
dodgeFrame = 0;
totalDodgeFrames = sprite_get_number(asset_get_index("spr_player_dodge"));

isShielding = false;

// enemy lock on stuff
isLockedOn = false;
lockOnList = ds_list_create();
lockOnListSeen = ds_list_create();
lockOnTarget = noone;
lockOnTargetType = obj_enemy_parent;
LOCK_ON_DISTANCE = 800;

// hp / stamina
hp = 100;
maxHp = 100;
hpRegen = .5; // per second
stamina = 50;
maxStamina = 50;
staminaRegen = 10; // per second

// level stuff
level = 1;
xp = 500;
xpToNextLevel = 1000;

// list of enemy attack instances been hit with -- only get hit once / attack
beenHitWith = ds_list_create();

poise = 100;
staggerDuration = 0;
staggerFrame = 0;
staggerDirection = 0;
staggerSpeed = noone; // optional -- used to indicate slow staggers, mainly

// spells stuff
knownSpells = ds_map_create();
ds_map_add(knownSpells, "magicmissile", instance_create_depth(x,y,1,obj_spell_magicmissile));
ds_map_add(knownSpells, "projectile", instance_create_depth(x,y,1,obj_spell_projectile));
ds_map_add(knownSpells, "aoe", instance_create_depth(x,y,1,obj_spell_aoe));
currentSpell = ds_map_find_first(knownSpells);
currentUsingSpell = noone;

attunementLevels = ds_map_create();
ds_map_add(attunementLevels,MAGIC,1);
ds_map_add(attunementLevels,FIRE,1);
ds_map_add(attunementLevels,ICE,1);
ds_map_add(attunementLevels,POISON,1);
ds_map_add(attunementLevels,LIGHTNING,1);
currentSpellAttunement = MAGIC;

// inventory -- holds all items
inventory = ds_list_create();
/*
//ds_list_add(inventory,instance_create_depth(x,y,1,obj_hand_item_crossbow));
var woodshield = instance_create_depth(x,y,1,obj_hand_item_woodshield);
woodshield.persistent = true;
ds_list_add(inventory,woodshield);
//ds_list_add(inventory,instance_create_depth(x,y,1,obj_hand_item_staff));
var shortbow = instance_create_depth(x,y,1,obj_hand_item_shortbow);
shortbow.persistent = true;
ds_list_add(inventory,shortbow);

var longsword2 = instance_create_depth(x,y,1,obj_hand_item_longsword);
longsword2.persistent = true;
ds_map_replace(longsword2.damages,ICE,[2,4]);
ds_list_add(inventory,longsword2);*/

var longsword = instance_create_depth(x,y,1,obj_hand_item_longsword);
longsword.persistent = true;
ds_map_replace(longsword.damages,MAGIC,[2,4]);
ds_list_add(inventory,longsword);

lastFountain = noone;
lastFountainRoom = noone;
lastFountainX = noone;
lastFountainY = noone;
lastFountainZ = noone;

gamePadIndex = noone;

layerToMoveTo = noone;

dyingParticleColor1 = c_white;
dyingParticleColor2 = c_gray;
justRevivedAtFountain = false;

enum WeaponTypes {
	Sword1H,
	Sword2H,
	Unarmed,
	Pointy1H, // Rapiers
	Pointy2H, // Spears, Halberd, Trident
	Axe1H,
	Axe2H,
	Blunt1H, // includes wands
	Blunt2H, // includes staves
	Dagger,
	Bow,
	Crossbow,
	Shuriken,
	Musket,
	Thrown,
	Pistol
}

#macro SWORD1H "1H Sword"
#macro SWORD2H "2H Sword"
#macro DAGGER "Dagger"
#macro UNARMED "Unarmed"
#macro AXE1H "1H Axe"
#macro AXE2H "2H Axe"
#macro BLUNT1H "1H Club"
#macro BLUNT2H "2H Club"
#macro RAPIER "Rapier"
#macro SPEAR "Spear"
#macro BOW "Bow"
#macro CROSSBOW "Crossbow"
#macro SHURIKEN "Shuriken"
#macro MUSKET "Musket"
#macro THROWN "Thrown"
#macro PISTOL "Pistol"
global.ALL_WEAPON_TYPES = [
	SWORD1H, SWORD2H, DAGGER, UNARMED, AXE1H, AXE2H, BLUNT1H, BLUNT2H, RAPIER, SPEAR,
	BOW, CROSSBOW, SHURIKEN, MUSKET, THROWN, PISTOL
];

criticalsChance = ds_map_create(); // 0 - 100% chance for criticals with weapon types
criticalsDamage = ds_map_create(); // 0 - 100% additional damage on critical hit with weapon types
comboHitsToNextLevelMap = ds_map_create(); // each weapon type starts with x hits needed to get combo multiplier

for (var i = 0; i < array_length_1d(global.ALL_WEAPON_TYPES); i++) {
	var wt = global.ALL_WEAPON_TYPES[i];
	ds_map_replace(criticalsChance,wt,15);
	ds_map_replace(criticalsDamage,wt,50); // by default, +50% base damage on crits
	if wt == UNARMED {
		ds_map_replace(comboHitsToNextLevelMap,wt,3);
	} else {
		ds_map_replace(comboHitsToNextLevelMap,wt,5);
	}
}

// criticals chances / damages with spells
var cs = ds_map_find_first(knownSpells);
for (var i = 0; i < ds_map_size(knownSpells); i++) {
	ds_map_replace(criticalsChance,cs,15);
	ds_map_replace(criticalsDamage,cs,50);
	cs = ds_map_find_next(knownSpells,cs);
}

var leftHandItem = getItemInEquipmentSlot(EquipmentSlots.LeftHand1);
comboHitsToNextLevel = ds_map_find_value(comboHitsToNextLevelMap,leftHandItem.weaponType);

offHandDamagePercent = 50; // by default, offhand weapon deals 50% damage

moveSprite = asset_get_index("spr_"+spriteString+"_move");
moveSpriteImageSpeed = 30;
if moveSprite != -1 {
	moveSpriteImageSpeed = sprite_get_speed(moveSprite);
}
