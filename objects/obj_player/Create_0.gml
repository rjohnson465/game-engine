if instance_number(object_index) > 1 {
	instance_destroy(id,0);
	exit;
}

global.player = id;
alarm[2] = 15; // ensure player isn't "stuck" every 15 frames
if room == game_menu && global.playerDoNothing {
	//instance_deactivate_object(id);
	exit;
} 
playerLightRadius = noone;

layer = layer_get_id("instances_floor_1");

event_inherited();


global.isLooting = false;
global.canLoot = false;
global.isWishing = false;
global.fountainGui = noone;
global.canInteractWithNpc = false;
global.isInteractingWithNpc = false;
global.isTrading = false;
global.isReadingTutorial = false;
functionalSpeed = 6;
normalSpeed = 6;
facingDirection = 0;
isSprinting = false;

spriteType = "player";
spriteString = "player";
isFairy = true;
isFloating = true;
type = CombatantTypes.Player;

// gui
isMouseInMenu = false;
if !instance_exists(obj_player_gui) {
	instance_create_depth(x,y,1,obj_player_gui);
}

enum EquipmentSlots {
	Head,
	LeftHand1,
	LeftHand2,
	RightHand1,
	RightHand2,
	LeftRing1,
	LeftRing2,
	RightRing1,
	RightRing2,
	BeltItem1,
	BeltItem2,
	BeltItem3,
	BeltItem4,
	BeltItem5
}

tutorialFirstsMap = defineFirstsTutorialMessages();

// grow hands 
hasHands = true; 

with obj_hand_item_unarmed {
	if persistent instance_destroy(id,1);
}
unarmed = instance_create_depth(x,y,1,obj_hand_item_unarmed);
unarmed.persistent = true;
unarmed.owner = id;

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
dodgeRestFrame = 0;
DODGE_REST_TOTAL_FRAMES = 16;
dodgeAgain = false;
totalDodgeFrames = sprite_get_number(asset_get_index("spr_player_dodge"));
totalDodgeFrames = 20;

isShielding = false;

// enemy lock on stuff
isLockedOn = false;
lockOnList = ds_list_create();
lockOnListSeen = ds_list_create();
lockOnTarget = noone;
lockOnTargetType = obj_enemy_parent;
LOCK_ON_DISTANCE = 5000;

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
xp = 0;
xpMultiplier = ds_map_find_value(propertiesBaseValues,ModifiableProperties.XpMultiplier); 
xpTemp = 0;
xpToNextLevel = 500;
skillPoints = 0;

// poise = ds_map_find_value(propertiesBaseValues,ModifiableProperties.Poise);
poiseMax = ds_map_find_value(propertiesBaseValues,ModifiableProperties.PoiseMax);
poiseCurrent = poiseMax;
poiseRegen = 1;

equipmentLoadCurrent = 0;
equipmentLoadMax = ds_map_find_value(propertiesBaseValues, ModifiableProperties.EquipmentLoad);

staggerDuration = 0;
staggerFrame = 0;
staggerDirection = 0;
staggerSpeed = noone; // optional -- used to indicate slow staggers, mainly

// spells stuff
// spell instances created by obj_skills_manager
var skm = global.skillManager;
ds_map_add(knownSpells, "magicmissile", skm.skillMagicMissile);
ds_map_add(knownSpells, "projectile", skm.skillBlast);
ds_map_add(knownSpells, "aoe", skm.skillExplosion);
currentSpell = ds_map_find_first(knownSpells);
currentUsingSpell = noone;
hasAlertedNoMagicCharges = false;
// prevents accidental double casting
// the spell charge button must be released before casting another spell
justCastSpell = false; 


currentSpellAttunement = MAGIC;
isHoldingAttunemntSwapMode = false;
isEquippingBeltItem = false;

goldDropMultiplier = 100; // %
// inventory -- holds all items
inventory = ds_list_create();

/*
// inventory fullness map
// INVENTORY_MAX_CAPACITY = 50; // can store up to 50 of each item type
inventoryCapacityMap = ds_map_create();
ds_map_replace(inventoryCapacityMap, InventoryFilters.Head, 0);
ds_map_replace(inventoryCapacityMap, InventoryFilters.Melee, 0);
ds_map_replace(inventoryCapacityMap, InventoryFilters.Ranged, 0);
ds_map_replace(inventoryCapacityMap, InventoryFilters.Rings, 0);
ds_map_replace(inventoryCapacityMap, InventoryFilters.Other, 0);
*/

// only have flask in inventory if game started at not main menu (i.e. create event did not happen on a Load Game)
// When a New Game is made, give health flask programtically
/*
var hf = noone;
if instance_number(obj_fade) == 0 {
	var hfCount = instance_number(obj_item_health_flask);
	if instance_number(obj_item_health_flask) == 0 {
		hf = instance_create_depth(x,y,1,obj_item_health_flask);
		addItemToInventory(hf);
	}
} */


if global.populateInventory && !global.gameManager.isLoading {
	
	addItemToInventory(makeGold(0,0));
	/*
	addItemToInventory(instance_create_depth(x,y,1,obj_hand_item_woodshield ));
	addItemToInventory(instance_create_depth(x,y,1,obj_hand_item_buckler ));
	addItemToInventory(instance_create_depth(x,y,1,obj_hand_item_kiteshield ));

	var longsword = instance_create_depth(x,y,1,obj_hand_item_longsword);
	longsword.persistent = true;
	longsword.numberOfSockets = 3;
	// modifyWeaponElementalDamage(longsword, LIGHTNING, 1);
	// ds_map_replace(longsword.itemPropertyModifiersPts, WeaponProperties.ElementalDamageBonus, [LIGHTNING, 5]);
	//insertGemIntoItem(makeGem(obj_gem_lapis,CRACKED),longsword);
	//insertGemIntoItem(makeGem(obj_gem_emerald,CRACKED),longsword);
	//insertGemIntoItem(makeGem(obj_gem_hematite,CRACKED),longsword);
	addItemToInventory(longsword);
	
	addItemToInventory(makeGemPieces(obj_gempieces_amethyst, PILE));
	addItemToInventory(makeGemPieces(obj_gempieces_amethyst, GRAINS));
	addItemToInventory(makeGemPieces(obj_gempieces_amethyst, CHUNKS));
	addItemToInventory(makeGemPieces(obj_gempieces_amethyst, CHUNKS));
	addItemToInventory(makeGemPieces(obj_gempieces_amethyst, SHARDS));
	addItemToInventory(makeGemPieces(obj_gempieces_amethyst, SHARDS));
	addItemToInventory(makeGemPieces(obj_gempieces_amethyst, GRAINS));
	
	addItemToInventory(instance_create_depth(x,y,1,obj_hand_item_hatchet));
	addItemToInventory(instance_create_depth(x,y,1,obj_hand_item_wand));
	
	addItemToInventory(instance_create_depth(x,y,1,obj_hand_item_greatsword));
	addItemToInventory(instance_create_depth(x,y,1,obj_hat_plated_cap));
	addItemToInventory(instance_create_depth(x,y,1,obj_hat_ringed_coif));
	addItemToInventory(instance_create_depth(x,y,1,obj_hat_bike_helmet));
	addItemToInventory(instance_create_depth(x,y,1,obj_hat_construction_hat));
	
	addItemToInventory(instance_create_depth(x,y,1,obj_hand_item_spear));
	addItemToInventory(instance_create_depth(x,y,1,obj_hand_item_torch));
	addItemToInventory(makeGem(obj_gem_amethyst, CRACKED));
	addItemToInventory(makeGem(obj_gem_amethyst, FLAWLESS));
	addItemToInventory(instance_create_depth(x,y,1,obj_item_spearmint_elixir));
	addItemToInventory(instance_create_depth(x,y,1,obj_item_spearmint_elixir));
	
	addItemToInventory(instance_create_depth(x,y,1,obj_item_jalapeno));
	addItemToInventory(instance_create_depth(x,y,1,obj_item_club_soda));
	
	addItemToInventory(instance_create_depth(x,y,1,obj_item_razorade));
	addItemToInventory(instance_create_depth(x,y,1,obj_item_razorade));
	
	addItemToInventory(instance_create_depth(x,y,1,obj_item_lamplight));
	
	/*
	var ring = instance_create_depth(x,y,1,obj_item_ring);
	addItemProperty(ring, ModifiableProperties.XpMultiplier, 10);
	addItemProperty(ring, ModifiableProperties.Defenses,[PIERCE, 7]);
	addItemProperty(ring, ModifiableProperties.ElementalDamageTypesMultiplier,[MAGIC, 100]);
	addItemProperty(ring, ModifiableProperties.StaminaSteal,10);
	addItemToInventory(ring);
	var ring = instance_create_depth(x,y,1,obj_item_ring);
	addItemProperty(ring, ModifiableProperties.XpMultiplier, 10);
	addItemProperty(ring, ModifiableProperties.Defenses,[PIERCE, 7]);
	addItemProperty(ring, ModifiableProperties.ElementalDamageTypesMultiplier,[MAGIC, 100]);
	addItemProperty(ring, ModifiableProperties.StaminaSteal,10);
	addItemToInventory(ring);
	var ring = instance_create_depth(x,y,1,obj_item_ring);
	addItemProperty(ring, ModifiableProperties.XpMultiplier, 10);
	addItemProperty(ring, ModifiableProperties.Defenses,[PIERCE, 7]);
	addItemProperty(ring, ModifiableProperties.ElementalDamageTypesMultiplier,[MAGIC, 100]);
	addItemProperty(ring, ModifiableProperties.StaminaSteal,10);
	addItemToInventory(ring); */
	
	
	/*
	addItemToInventory(instance_create_depth(x,y,1,obj_hand_item_warhammer));
	addItemToInventory(instance_create_depth(x,y,1,obj_hand_item_torch));
	addItemToInventory(instance_create_depth(x,y,1,obj_item_revive_orb));
	addItemToInventory(instance_create_depth(x,y,1,obj_hand_item_crossbow));
	var shortbow = instance_create_depth(x,y,1,obj_hand_item_shortbow);
	shortbow.numberOfSockets = 3;
	insertGemIntoItem(makeGem(obj_gem_aquamarine,FLAWLESS),shortbow);
	addItemToInventory(shortbow);
	addItemToInventory(instance_create_depth(x,y,1,obj_hand_item_spear));
	addItemToInventory(instance_create_depth(x,y,1,obj_hat_leathercap));
	
	addItemToInventory(instance_create_depth(x,y,1,obj_hand_item_greatsword));
	addItemToInventory(instance_create_depth(x,y,1,obj_hand_item_hatchet));
	addItemToInventory(instance_create_depth(x,y,1,obj_hand_item_battleaxe));
	addItemToInventory(instance_create_depth(x,y,1,obj_hand_item_club));
	addItemToInventory(instance_create_depth(x,y,1,obj_hand_item_dagger));
	addItemToInventory(instance_create_depth(x,y,1,obj_hand_item_foil));
	addItemToInventory(instance_create_depth(x,y,1,obj_hand_item_warhammer));
	addItemToInventory(instance_create_depth(x,y,1,obj_hand_item_shortbow));
	addItemToInventory(instance_create_depth(x,y,1,obj_hand_item_pistol));
	addItemToInventory(instance_create_depth(x,y,1,obj_hand_item_thrownknife));
	addItemToInventory(instance_create_depth(x,y,1,obj_hand_item_spear));
	addItemToInventory(instance_create_depth(x,y,1,obj_hand_item_shuriken));
	addItemToInventory(instance_create_depth(x,y,1,obj_hand_item_arquebus));
	addItemToInventory(instance_create_depth(x,y,1,obj_hand_item_crossbow));
	addItemToInventory(instance_create_depth(x,y,1,obj_hand_item_wand));
	
	addItemToInventory(makeGem(obj_gem_amethyst,FLAWLESS));
	addItemToInventory(makeGem(obj_gem_amethyst,FLAWLESS));
	addItemToInventory(makeGem(obj_gem_amethyst,FLAWLESS));
	addItemToInventory(makeGem(obj_gem_amethyst,FLAWLESS));
	addItemToInventory(makeGem(obj_gem_hematite,FLAWLESS));
	addItemToInventory(makeGem(obj_gem_ruby,FLAWLESS));
	
	var ring = instance_create_depth(x,y,1,obj_item_ring);
	addItemProperty(ring, ModifiableProperties.XpMultiplier, 10);
	addItemProperty(ring, ModifiableProperties.Defenses,[PIERCE, 7]);
	addItemProperty(ring, ModifiableProperties.ElementalDamageTypesMultiplier,[MAGIC, 100]);
	addItemProperty(ring, ModifiableProperties.StaminaSteal,10);
	//ds_map_replace(ring.itemProperties,ModifiableProperties.XpMultiplier,10);
	//ds_map_replace(ring.itemProperties,ModifiableProperties.Defenses,[PIERCE,7]);
	//ds_map_replace(ring.itemProperties,ModifiableProperties.ElementalDamageTypesMultiplier,[MAGIC,100]);
	//ds_map_replace(ring.itemProperties,ModifiableProperties.StaminaSteal,10);
	addItemToInventory(ring);
	addItemToInventory(instance_create_depth(x,y,1,obj_item_jalapeno));
	addItemToInventory(instance_create_depth(x,y,1,obj_item_jalapeno));
	addItemToInventory(instance_create_depth(x,y,1,obj_item_jalapeno));
	addItemToInventory(instance_create_depth(x,y,1,obj_item_antidote));
	addItemToInventory(instance_create_depth(x,y,1,obj_item_antidote));
	addItemToInventory(instance_create_depth(x,y,1,obj_item_antidote));
	addItemToInventory(instance_create_depth(x,y,1,obj_item_icecube));
	addItemToInventory(instance_create_depth(x,y,1,obj_item_icecube));
	
	addItemToInventory(instance_create_depth(x,y,1,obj_item_rubberducky));
	addItemToInventory(instance_create_depth(x,y,1,obj_item_rubberducky));
	
	addItemToInventory(instance_create_depth(x,y,1,obj_item_blessing));
	addItemToInventory(instance_create_depth(x,y,1,obj_item_blessing));
	
	addItemToInventory(makeGemPieces(obj_gempieces_ruby, GRAINS));
	addItemToInventory(makeGemPieces(obj_gempieces_ruby, GRAINS));
	addItemToInventory(makeGemPieces(obj_gempieces_amethyst, GRAINS));
	addItemToInventory(makeGemPieces(obj_gempieces_amethyst, GRAINS));
	addItemToInventory(makeGemPieces(obj_gempieces_aquamarine, GRAINS));
	addItemToInventory(makeGemPieces(obj_gempieces_aquamarine, PILE));
	addItemToInventory(makeGemPieces(obj_gempieces_emerald, PILE));
	addItemToInventory(makeKey("Warden's Key","key",spr_item_key, "'Oh boy I hope the inmates don't find this.' - Warden Bob, last known words"));
*/

} // end populate inventory

lastFountain = instance_nearest(x,y,obj_fountain);
lastFountainRoom = noone
lastFountainX = noone;
lastFountainY = noone;
lastFountainZ = noone;

gamePadIndex = -1;
if !global.gameManager.isLoading {
	layerToMoveTo = "instances_floor_1";
}
if variable_global_exists("gamePadIndex") {
	gamePadIndex = global.gamePadIndex;
}

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

rightHandItem = getItemInEquipmentSlot(EquipmentSlots.RightHand1);
leftHandItem = getItemInEquipmentSlot(EquipmentSlots.LeftHand1);
comboHitsToNextLevel = ds_map_find_value(comboHitsToNextLevelMap,leftHandItem.weaponType);

offHandDamagePercent = ds_map_find_value(propertiesBaseValues,ModifiableProperties.OffHandDamage); // by default, offhand weapon deals 50% damage

moveSprite = asset_get_index("spr_"+spriteString+"_move");
moveSpriteImageSpeed = 30;
if moveSprite != -1 {
	moveSpriteImageSpeed = sprite_get_speed(moveSprite);
}

hasIssuedAmmoOut = false;

quests = ds_list_create();
questsAtRewardStepCount = 0;

// holds a list of all the objects currently "vying for interaction" that are not explicitly prioritied
// the first object that wants attention (in pos 0) will be adressed first
nonPriorityInteractionPrompts = ds_list_create(); 

interactableObjects = ds_list_create();
currentInteractableObject = noone;
interactableResetFrame = 0;

ds_map_destroy(tutorialFirstsMap); tutorialFirstsMap = -1;
tutorialFirstsMap = defineFirstsTutorialMessages(); // redo

// to sprint, the B button must be held for 1/3 second
isHoldingSprintButton = false;
sprintCounterTotal = 10;
sprintCounter = sprintCounterTotal;
sprintNeedsReset = false;

// belt items
beltItems[0] = noone;
beltItems[1] = noone;
beltItems[2] = noone;
beltItems[3] = noone;
beltItems[4] = noone;
currentBeltItemIndex = 0; // this is the index of item that will be used when X is pressed

/*
if hf != noone {
	equipItem(hf, EquipmentSlots.BeltItem1);
}
*/

healingFrame = 0;
healingTotalFrames = sprite_get_number(spr_player_heal);

// temp defenses -- a list of all temporary defenses
// each entry is an array [<defenseType>, <frames left>]
temporaryDefenses = ds_list_create();

narrativeState = NarrativeState.Start;

faceSprite = spr_face_gary;

name = "Gary";


// TEST
// var key = makeKey("Great-Lodge F2 Key", "key", spr_item_key, "Opens the door to the Fairy's Great-Lodge, Level 2. We really should have more than one copy of this thing.");
// addItemToInventory(key);
// questStartUnfairySlayer();
// questStart(obj_quest_wamdk);