
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

#macro C_HANDLES make_color_rgb(47,79,79)
#macro C_DKRGRAY make_color_rgb(42,42,42)

global.ALL_ELEMENTS = [MAGIC,FIRE,ICE,POISON,LIGHTNING];
global.ALL_DAMAGE_TYPES = [PHYSICAL,SLASH,PIERCE,CRUSH,MAGIC,FIRE,ICE,POISON,LIGHTNING];
global.ALL_PHYSICAL_DAMAGE_TYPES = [PHYSICAL,SLASH,PIERCE,CRUSH];
playerLightRadius = noone;

event_inherited();
global.player = id;
global.isLooting = false;
global.canLoot = false;
global.isWishing = false;
global.fountainGui = noone;
global.canInteractWithNpc = false;
global.isInteractingWithNpc = false;
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

defineItemsByAct();

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

// can only do one charge attack at a time, while charging, cannot perform any other attacks
chargeFrame = -10;
CHARGE_FRAME_THRESHOLD = 0; // 5 frames to start a charge attack
CHARGE_FRAME_TOTAL = 25; // additional frames to hold charge for

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

#macro SWORD1H "Sword/1H"
#macro SWORD2H "Sword/2H"
#macro DAGGER "Dagger/1H"
#macro UNARMED "Unarmed"
#macro AXE1H "Axe/1H"
#macro AXE2H "Axe/2H"
#macro BLUNT1H "Club/1H"
#macro BLUNT2H "Club/2H"
#macro RAPIER "Rapier/1H"
#macro SPEAR "Spear/2H"
#macro BOW "Bow/2H"
#macro CROSSBOW "Crossbow/1H"
#macro SHURIKEN "Shuriken/2H"
#macro MUSKET "Musket/2H"
#macro THROWN "Thrown/1H"
#macro PISTOL "Pistol/1H"

global.ALL_WEAPON_TYPES = [
	SWORD1H, SWORD2H, DAGGER, UNARMED, AXE1H, AXE2H, BLUNT1H, BLUNT2H, RAPIER, SPEAR,
	BOW, CROSSBOW, SHURIKEN, MUSKET, THROWN, PISTOL
];

propertiesBaseValues = defineBasePlayerProperties();
itemPropertyBonuses = ds_map_create();
skillPropertyBonuses = ds_map_create();

// hp / stamina
showHp = true;
hp = ds_map_find_value(propertiesBaseValues,ModifiableProperties.HpMax); 
maxHp = ds_map_find_value(propertiesBaseValues,ModifiableProperties.HpMax);
hpRegen = ds_map_find_value(propertiesBaseValues,ModifiableProperties.HpRegen);
stamina = ds_map_find_value(propertiesBaseValues,ModifiableProperties.StaminaMax);
maxStamina = ds_map_find_value(propertiesBaseValues,ModifiableProperties.StaminaMax);
staminaRegen = ds_map_find_value(propertiesBaseValues,ModifiableProperties.StaminaRegen);
hpSteal = ds_map_find_value(propertiesBaseValues,ModifiableProperties.HpSteal);
staminaSteal = ds_map_find_value(propertiesBaseValues,ModifiableProperties.StaminaSteal);

physicalDamageTypesMultipliers = ds_map_create();
var physicalDamages = [SLASH, PIERCE, CRUSH, PHYSICAL];
for (var i = 0; i < array_length_1d(physicalDamages); i++) {
	var mapToSearch = ds_map_find_value(propertiesBaseValues,ModifiableProperties.PhysicalDamageTypesMultiplier);
	ds_map_replace(physicalDamageTypesMultipliers,physicalDamages[i],ds_map_find_value(mapToSearch,physicalDamages[i]));
}
elementalDamageTypesMultipliers = ds_map_create();
for (var i = 0; i < array_length_1d(global.ALL_ELEMENTS); i++) {
	var mapToSearch = ds_map_find_value(propertiesBaseValues,ModifiableProperties.ElementalDamageTypesMultiplier);
	ds_map_replace(elementalDamageTypesMultipliers,global.ALL_ELEMENTS[i],ds_map_find_value(mapToSearch,global.ALL_ELEMENTS[i]));
}

// level stuff
level = 1;
xp = 500;
xpMultiplier = ds_map_find_value(propertiesBaseValues,ModifiableProperties.XpMultiplier); 
xpTemp = 0;
xpToNextLevel = 1000;
skillPoints = 0;

// list of enemy attack instances been hit with -- only get hit once / attack
beenHitWith = ds_list_create();

poise = ds_map_find_value(propertiesBaseValues,ModifiableProperties.Poise);
staggerDuration = 0;
staggerFrame = 0;
staggerDirection = 0;
staggerSpeed = noone; // optional -- used to indicate slow staggers, mainly

// spells stuff
knownSpells = ds_map_create();
// spell instances created by obj_skills_manager
ds_map_add(knownSpells, "magicmissile", obj_spell_magicmissile);
ds_map_add(knownSpells, "projectile", obj_spell_projectile);
ds_map_add(knownSpells, "aoe", obj_spell_aoe);
currentSpell = ds_map_find_first(knownSpells);
currentUsingSpell = noone;
hasAlertedNoMagicCharges = false;

attunementLevels = ds_map_create();
ds_map_add(attunementLevels,MAGIC,1);
ds_map_add(attunementLevels,FIRE,1);
ds_map_add(attunementLevels,ICE,1);
ds_map_add(attunementLevels,POISON,1);
ds_map_add(attunementLevels,LIGHTNING,1);
currentSpellAttunement = MAGIC;

// inventory -- holds all items
inventory = ds_list_create();
addItemToInventory(makeGold(100000,200000));
//ds_list_add(inventory,instance_create_depth(x,y,1,obj_hand_item_crossbow));

var woodshield = instance_create_depth(x,y,1,obj_hand_item_woodshield);
woodshield.persistent = true;
addItemToInventory(woodshield);
//ds_list_add(inventory,instance_create_depth(x,y,1,obj_hand_item_staff));
var shortbow = instance_create_depth(x,y,1,obj_hand_item_shortbow);
shortbow.numberOfSockets = 2;
shortbow.persistent = true;
//ds_list_add(inventory,shortbow);
addItemToInventory(shortbow);

var longsword2 = instance_create_depth(x,y,1,obj_hand_item_longsword);
longsword2.persistent = true;
longsword2.durability = 0;
//ds_map_replace(longsword2.damages,ICE,[2,4]);
addItemToInventory(longsword2);

var longsword = instance_create_depth(x,y,1,obj_hand_item_longsword);
longsword.persistent = true;
longsword.numberOfSockets = 3;
insertGemIntoItem(makeGem(obj_gem_lapis,CRACKED),longsword);
insertGemIntoItem(makeGem(obj_gem_aquamarine,CRACKED),longsword);
insertGemIntoItem(makeGem(obj_gem_hematite,CRACKED),longsword);
addItemToInventory(longsword);

addItemToInventory(instance_create_depth(x,y,1,obj_hand_item_dagger));
addItemToInventory(instance_create_depth(x,y,1,obj_hand_item_battleaxe));

addItemToInventory(instance_create_depth(x,y,1,obj_item_revive_orb));
addItemToInventory(instance_create_depth(x,y,1,obj_item_revive_orb));
var ring = instance_create_depth(x,y,1,obj_item_ring);
ds_map_add(ring.itemProperties,ModifiableProperties.StaminaMax,50);
ds_map_add(ring.itemProperties,ModifiableProperties.StaminaRegen,10);
addItemToInventory(ring);
addItemToInventory(instance_create_depth(x,y,1,obj_hat_leathercap));
addItemToInventory(makeGem(obj_gem_aquamarine,CRACKED));
addItemToInventory(makeGem(obj_gem_aquamarine,CRACKED));

addItemToInventory(makeGem(obj_gem_lapis,CRACKED));
addItemToInventory(makeGem(obj_gem_topaz,CRACKED));
addItemToInventory(makeGem(obj_gem_emerald,CRACKED));
addItemToInventory(makeGem(obj_gem_ruby,CRACKED));
addItemToInventory(makeGem(obj_gem_hematite,CRACKED));


// bs
/*
addItemToInventory(instance_create_depth(x,y,1,obj_hand_item_shortbow));
addItemToInventory(instance_create_depth(x,y,1,obj_hand_item_longsword));
addItemToInventory(instance_create_depth(x,y,1,obj_hand_item_woodshield));
addItemToInventory(instance_create_depth(x,y,1,obj_hat_leathercap));
addItemToInventory(instance_create_depth(x,y,1,obj_hand_item_shortbow));
addItemToInventory(instance_create_depth(x,y,1,obj_hand_item_longsword));
addItemToInventory(instance_create_depth(x,y,1,obj_hand_item_woodshield));
addItemToInventory(instance_create_depth(x,y,1,obj_hat_leathercap));
addItemToInventory(instance_create_depth(x,y,1,obj_hand_item_shortbow));
addItemToInventory(instance_create_depth(x,y,1,obj_hand_item_longsword));
addItemToInventory(instance_create_depth(x,y,1,obj_hand_item_woodshield));
addItemToInventory(instance_create_depth(x,y,1,obj_hat_leathercap));
addItemToInventory(instance_create_depth(x,y,1,obj_hand_item_shortbow));
addItemToInventory(instance_create_depth(x,y,1,obj_hand_item_longsword));
addItemToInventory(instance_create_depth(x,y,1,obj_hand_item_woodshield));
addItemToInventory(instance_create_depth(x,y,1,obj_hat_leathercap));
addItemToInventory(instance_create_depth(x,y,1,obj_hand_item_shortbow));
addItemToInventory(instance_create_depth(x,y,1,obj_hand_item_longsword));
addItemToInventory(instance_create_depth(x,y,1,obj_hand_item_woodshield));
addItemToInventory(instance_create_depth(x,y,1,obj_hat_leathercap));
addItemToInventory(instance_create_depth(x,y,1,obj_hand_item_shortbow));
addItemToInventory(instance_create_depth(x,y,1,obj_hand_item_longsword));
addItemToInventory(instance_create_depth(x,y,1,obj_hand_item_woodshield));
addItemToInventory(instance_create_depth(x,y,1,obj_hat_leathercap));
*/



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

// CRITICALS / Weapon Types Damage / Combos

criticalsChance = ds_map_create(); // 0 - 100% chance for criticals with weapon types
criticalsDamage = ds_map_create(); // 0 - x% additional damage on critical hit with weapon types
weaponTypesDamage = ds_map_create(); // additional base damage for each weapon type
comboHitsToNextLevelMap = ds_map_create(); // each weapon type starts with x hits needed to get combo multiplier

for (var i = 0; i < array_length_1d(global.ALL_WEAPON_TYPES); i++) {
	var wt = global.ALL_WEAPON_TYPES[i];
	
	var chanceMap = ds_map_find_value(propertiesBaseValues,ModifiableProperties.CriticalsChance);
	var chanceVal = ds_map_find_value(chanceMap,wt);
	var damageMap = ds_map_find_value(propertiesBaseValues,ModifiableProperties.CriticalsDamage);
	var damageVal = ds_map_find_value(damageMap,wt);
	ds_map_replace(criticalsChance,wt,chanceVal);
	ds_map_replace(criticalsDamage,wt,damageVal);
	var wtDamageMap = ds_map_find_value(propertiesBaseValues,ModifiableProperties.WeaponTypesDamage);
	var wtDamageVal = ds_map_find_value(wtDamageMap,wt);
	ds_map_replace(weaponTypesDamage,wt,wtDamageVal);
	
	// TODO -- define in defineBaseProperties function
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

offHandDamagePercent = ds_map_find_value(propertiesBaseValues,ModifiableProperties.OffHandDamage); // by default, offhand weapon deals 50% damage

moveSprite = asset_get_index("spr_"+spriteString+"_move");
moveSpriteImageSpeed = 30;
if moveSprite != -1 {
	moveSpriteImageSpeed = sprite_get_speed(moveSprite);
}

hasIssuedAmmoOut = false;