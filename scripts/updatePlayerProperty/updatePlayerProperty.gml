/// updatePlayerProperty(prop,val,isItemProperty,*macro)
/// @param prop
/// @param val
/// @param isItemProperty boolean
/// @param *macro i.e. FIRE, SWORD1H

var prop = argument[0];
var val = argument[1];
var isItemProperty = argument[2];
var macro = noone;
if argument_count == 4 {
	macro = argument[3];
}
var p = global.player;

var currentVal = 0;
var otherVal = 0;

// get current item or skill bonus	
var mapToUpdate = isItemProperty ? p.itemPropertyBonuses : p.skillPropertyBonuses;
var otherMap = isItemProperty ? p.skillPropertyBonuses : p.itemPropertyBonuses;

if macro == noone {
	// the current item or skill bonus value
	currentVal = ds_map_find_value(mapToUpdate,prop);
	if currentVal == undefined currentVal = 0;
	// update the player's mapToUpdate value correctly
	ds_map_replace(mapToUpdate,prop,currentVal+val);
	// the current skill / item (whichever is NOT being updated now) bonus value 
	otherVal = ds_map_find_value(otherMap,prop);
	if otherVal == undefined otherVal = 0;
} else {
	
	// yo this is fucked.
	
	// get the map of all macro values (i.e. critical hit chances)
	var macroMap = ds_map_find_value(mapToUpdate,prop);
	// if macroMap is not defined yet, create it 
	if macroMap == undefined {
		macroMap = ds_map_create();
	}
	
	// get the value for this macro in macroMap (i.e. critial hits with SWORD1H)
	currentVal = ds_map_find_value(macroMap,macro);
	// if no value is defined at this macro key, add it to macroMap key macro with val 0
	if currentVal == undefined {
		currentVal = 0;
		ds_map_replace(macroMap,macro,currentVal);
	}
	
	// update the player's mapToUpdate at key "prop" with val "macroMap"
	if isItemProperty {
		ds_map_replace(p.itemPropertyBonuses,prop,macroMap);
	}
	else {
		ds_map_replace(p.skillPropertyBonuses,prop,macroMap);
	}
	
	// update the player's macroMap value correctly
	ds_map_replace(macroMap,macro,currentVal+val);
	
	// OTHER BONUS
	// find the skill / item bonus value (whichever is NOT being updated now)
	var otherMacroMap = ds_map_find_value(otherMap,prop);
	if otherMacroMap == undefined {
		otherMacroMap = ds_map_create();
	}
	
	// get the specific value for this macro in otherMacroMap
	otherVal = ds_map_find_value(otherMacroMap,macro);
	if otherVal == undefined {
		otherVal = 0;
		ds_map_replace(otherMacroMap,macro,otherVal);
	}
	if isItemProperty {
		ds_map_replace(p.skillPropertyBonuses,prop,otherMacroMap);
	}
	else {
		ds_map_replace(p.itemPropertyBonuses,prop,otherMacroMap);
	}
}
	
// the base stat value
var base = 0;
if macro == noone {
	base = ds_map_find_value(p.propertiesBaseValues,prop);
} else {
	var mapToSearch = ds_map_find_value(p.propertiesBaseValues,prop);
	base = ds_map_find_value(mapToSearch,macro);
}
	
var newVal = base + otherVal + (currentVal + val);

// set actual player property, taking into account item props + skill props
switch prop {
	case ModifiableProperties.HpRegen: {
		p.hpRegen = newVal; break;
	}
	case ModifiableProperties.StaminaRegen: {
		p.staminaRegen = newVal; break;
	}
	case ModifiableProperties.StaminaMax: {
		p.maxStamina = newVal; break;
	}
	case ModifiableProperties.HpMax: {
		p.maxHp = newVal; break;
	}
	case ModifiableProperties.OffHandDamage: {
		p.offHandDamagePercent = newVal; break;
	}
	case ModifiableProperties.CriticalsChance: {
		// update the entry in the player's criticalsChance map with the right macro key
		ds_map_replace(p.criticalsChance,macro,newVal); break;
	}
	case ModifiableProperties.CriticalsDamage: {
		ds_map_replace(p.criticalsDamage,macro,newVal); break;
	}
	case ModifiableProperties.WeaponTypesDamage: {
		ds_map_replace(p.weaponTypesDamage,macro,newVal); break;
	}
}

if p.hp > p.maxHp p.hp = p.maxHp;
if p.stamina > p.maxStamina p.stamina = p.maxStamina;