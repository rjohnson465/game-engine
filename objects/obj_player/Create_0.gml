depth = 0;
// use macros for elements rather than enums (helps with sprite getting)
#macro PHYSICAL "physical"
#macro MAGIC "magic"
#macro FIRE "fire"
#macro ICE "ice"
#macro POISON "poison"
#macro LIGHTNING "lightning"
#macro BLEED "bleed"
global.ALL_ELEMENTS = [MAGIC,FIRE,ICE,POISON,LIGHTNING];
global.ALL_DAMAGE_TYPES = [PHYSICAL, MAGIC,FIRE,ICE,POISON,LIGHTNING, BLEED];

event_inherited();
global.player = id;
functionalSpeed = 6;
normalSpeed = 6;
facingDirection = 0;

spriteType = "player";
spriteString = "player";
type = CombatantTypes.Player;

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
equippedItems = ds_map_create();
ds_map_add(equippedItems,EquipmentSlots.Head,noone);
ds_map_add(equippedItems,EquipmentSlots.LeftHand1,instance_create_depth(x,y,1,obj_hand_item_longsword));
ds_map_add(equippedItems,EquipmentSlots.LeftHand2,unarmed);
ds_map_add(equippedItems,EquipmentSlots.RightHand1,instance_create_depth(x,y,1,obj_hand_item_longsword));
ds_map_add(equippedItems,EquipmentSlots.RightHand2,instance_create_depth(x,y,1,obj_hand_item_staff));
ds_map_add(equippedItems,EquipmentSlots.LeftRing1,noone);
ds_map_add(equippedItems,EquipmentSlots.LeftRing2,noone);
ds_map_add(equippedItems,EquipmentSlots.RightRing1,noone);
ds_map_add(equippedItems,EquipmentSlots.RightRing2,noone);
leftHandItem = ds_map_find_value(global.player.equippedItems,EquipmentSlots.LeftHand1);
leftHandItem2 = ds_map_find_value(global.player.equippedItems,EquipmentSlots.LeftHand2);
rightHandItem = ds_map_find_value(global.player.equippedItems,EquipmentSlots.RightHand1);
rightHandItem2 = ds_map_find_value(global.player.equippedItems,EquipmentSlots.RightHand2);

// attack states
global.playerAttackNumberInChain = 1; // in chain
/*isPreparingAttack = false;
isAttacking = false;
isRecovering = false;
attackAgain = false; // boolean that says whether to attack again (when possible) even if already attacking
attackAgainSameSide = false;*/
// <handSide><bool> kvp's
attackAgain = ds_map_create();
isReadyToFire = false; // ranged only boolean

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
staminaRegen = 6; // per second

/*// attributes
strength = 10;
dexterity = 10;
intelligence = 10;
constitution = 10;
adaptability = 10;*/

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
ds_list_add(inventory,instance_create_depth(x,y,1,obj_hand_item_crossbow));
ds_list_add(inventory,instance_create_depth(x,y,1,obj_hand_item_woodshield));
ds_list_add(inventory,instance_create_depth(x,y,1,obj_hand_item_staff));
ds_list_add(inventory,instance_create_depth(x,y,1,obj_hand_item_longsword));
ds_list_add(inventory,instance_create_depth(x,y,1,obj_hand_item_shortbow));

// gui
isMouseInMenu = false;
instance_create_depth(x,y,1,obj_GUI);

ds_map_replace(defenses,ICE,75);