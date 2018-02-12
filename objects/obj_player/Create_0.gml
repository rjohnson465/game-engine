depth = 0;
// use macros for elements rather than enums (helps with sprite getting)
#macro PHYSICAL "physical"
#macro MAGIC "magic"
#macro FIRE "fire"
#macro ICE "ice"
#macro POISON "poison"
#macro LIGHTNING "lightning"

global.ALL_ELEMENTS = [MAGIC,FIRE,ICE,POISON,LIGHTNING];
global.ALL_DAMAGE_TYPES = [PHYSICAL, MAGIC,FIRE,ICE,POISON,LIGHTNING];

event_inherited();
global.player = id;
functionalSpeed = 6;
normalSpeed = 6;
facingDirection = 0;

spriteType = "player";
spriteString = "player";
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
/*var longsword = instance_create_depth(x,y,1,obj_hand_item_longsword);
ds_list_add(equippedItems,longsword);
longsword.equipmentSlot = EquipmentSlots.RightHand1;
longsword.persistent = true;
ds_map_replace(equippedLimbItems,"r",longsword);
var shortbow = instance_create_depth(x,y,1,obj_hand_item_shortbow);
ds_list_add(equippedItems,shortbow);
shortbow.equipmentSlot = EquipmentSlots.RightHand2;
shortbow.persistent = true;
ds_map_replace(equippedLimbItems,"l",unarmed);
ds_map_replace(equippedLimbItems,"l2",unarmed);
ds_map_replace(equippedLimbItems,"r2",shortbow);*/

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
hp = 1;
maxHp = 500;
hpRegen = .5; // per second
stamina = 500;
maxStamina = 500;
staminaRegen = 15; // per second

// level stuff
level = 1;
xp = 500;
xpToNextLevel = 1000;

// list of enemy attack instances been hit with -- only get hit once / attack
beenHitWith = ds_list_create();

poise = 15;
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
//ds_list_add(inventory,instance_create_depth(x,y,1,obj_hand_item_crossbow));
ds_list_add(inventory,instance_create_depth(x,y,1,obj_hand_item_woodshield));
//ds_list_add(inventory,instance_create_depth(x,y,1,obj_hand_item_staff));
ds_list_add(inventory,instance_create_depth(x,y,1,obj_hand_item_shortbow));
ds_list_add(inventory,instance_create_depth(x,y,1,obj_hand_item_longsword));
/*ds_list_add(inventory,longsword);
ds_list_add(inventory,shortbow);
ds_list_add(inventory,instance_create_depth(x,y,1,obj_hand_item_crossbow));
ds_list_add(inventory,instance_create_depth(x,y,1,obj_hand_item_woodshield));
ds_list_add(inventory,instance_create_depth(x,y,1,obj_hand_item_staff));
ds_list_add(inventory,instance_create_depth(x,y,1,obj_hand_item_shortbow));
ds_list_add(inventory,instance_create_depth(x,y,1,obj_hand_item_staff));
ds_list_add(inventory,instance_create_depth(x,y,1,obj_hand_item_staff));
ds_list_add(inventory,instance_create_depth(x,y,1,obj_hand_item_crossbow));
ds_list_add(inventory,instance_create_depth(x,y,1,obj_hand_item_woodshield));
ds_list_add(inventory,instance_create_depth(x,y,1,obj_hand_item_shortbow));
ds_list_add(inventory,instance_create_depth(x,y,1,obj_hand_item_staff));
ds_list_add(inventory,instance_create_depth(x,y,1,obj_hand_item_staff));

ds_list_add(inventory,instance_create_depth(x,y,1,obj_hand_item_staff));
ds_list_add(inventory,instance_create_depth(x,y,1,obj_hand_item_staff));
ds_list_add(inventory,instance_create_depth(x,y,1,obj_hand_item_crossbow));
ds_list_add(inventory,instance_create_depth(x,y,1,obj_hand_item_woodshield));
ds_list_add(inventory,instance_create_depth(x,y,1,obj_hand_item_shortbow));
ds_list_add(inventory,instance_create_depth(x,y,1,obj_hand_item_staff));
ds_list_add(inventory,instance_create_depth(x,y,1,obj_hand_item_staff));*/

lastFountainRoom = noone;
lastFountainX = noone;
lastFountainY = noone;

var playerId = id;
with obj_light_radius {
	if owner == playerId {
		persistent = true;
	}
}