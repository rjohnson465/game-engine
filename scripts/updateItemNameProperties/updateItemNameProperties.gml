/// updateItemNameProperties(item)
/// @param item
/// update an item's name based on the properties it has so far

var item = argument[0];

// get all property keys in item
var props = ds_list_create();
var prop = ds_map_find_first(item.itemProperties);
for (var i = 0; i < ds_map_size(item.itemProperties); i++) {
	ds_list_add(props,prop);
	prop = ds_map_find_next(item.itemProperties, prop);
}

// first, update prefixes (basic item properties)
var basicProps = [];
for (var i = 0; i < ds_list_size(props); i++) {
	var prop = ds_list_find_value(props, i);
	if arrayIncludes(global.basicItemProperties, prop) {
		basicProps[array_length_1d(basicProps)] = prop;
	}
}

// now with our basic properties, let's see what prefixes to add
var prefixes = ds_list_create();
for (var i = 0; i < array_length_1d(basicProps); i++) {
	var prop = basicProps[i];
	var val = ds_map_find_value(item.itemProperties, prop);
	var macro = val[0];
	ds_list_add(prefixes,getItemPropertyPrefix(prop,macro));
}

// suffix 2 decided by rare property(s)
var suffix2 = noone;
var rareProps = [];
for (var i = 0; i < ds_list_size(props); i++) {
	var prop = ds_list_find_value(props, i);
	if arrayIncludes(global.rareItemProperties, prop) {
		rareProps[array_length_1d(rareProps)] = prop;
	}
}
if array_length_1d(rareProps) > 0 {
	suffix2 = getItemPropertySuffix2(rareProps);
}

// suffix 1 decided by vrare props
var suffix1 = noone;
var vrareProps = [];
for (var i = 0; i < ds_list_size(props); i++) {
	var prop = ds_list_find_value(props, i);
	if arrayIncludes(global.vrareItemProperties, prop) {
		vrareProps[array_length_1d(vrareProps)] = prop;
	}
}
if array_length_1d(vrareProps) > 0 {
	suffix1 = getItemPropertySuffix1(vrareProps);
}

// build the item name
var prefixString = "";
// build the prefix string according to the following order:
// 1) weapon damage bonus
// 2) crit chance bonus
// 3) physical dmg bonus
// 4) elemental dmg bonus
// 5) crit dmg bonus
// 6) defense / resist bonus
var orderedPrefixes = ds_list_create();
ds_list_add(orderedPrefixes,getPrefixInMap(prefixes,global.weaponTypesDamagePrefixes));
ds_list_add(orderedPrefixes,getPrefixInMap(prefixes,global.criticalsChancePrefixes));
ds_list_add(orderedPrefixes,getPrefixInMap(prefixes,global.physicalMultiplierPrefixes));
ds_list_add(orderedPrefixes,getPrefixInMap(prefixes,global.elementalMultipliersPrefixes));
ds_list_add(orderedPrefixes,getPrefixInMap(prefixes,global.criticalsDamagePrefixes));
ds_list_add(orderedPrefixes,getPrefixInMap(prefixes,global.defensePrefixes));

for (var i = 0; i < ds_list_size(orderedPrefixes); i++) {
	
	var prefix = ds_list_find_value(orderedPrefixes,i);
	if (prefix == undefined || prefix == noone) continue;
	prefixString += prefix;
	prefixString += " ";
	
}

var newName = prefixString + item.gemmedName;
if suffix1 != noone || suffix2 != noone {
	newName += " of the ";
}
if suffix1 != noone {
	newName += suffix1 + " ";
}
if suffix2 != noone {
	newName += suffix2;
}
// TODO -- suffixes
item.name = newName;

ds_list_destroy(prefixes); prefixes = -1;
ds_list_destroy(orderedPrefixes); orderedPrefixes = -1;
//ds_list_destroy(basicProps);
ds_list_destroy(props); props = -1;