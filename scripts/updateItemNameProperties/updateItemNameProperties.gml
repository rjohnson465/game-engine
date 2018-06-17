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
for (var i = 0; i < ds_list_size(prefixes); i++) {
	var prefix = ds_list_find_value(prefixes,i);
	if prefix != undefined {
		prefixString += prefix;
		prefixString += " ";
	}
}
var newName = prefixString + item.baseName;
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

ds_list_destroy(prefixes);
//ds_list_destroy(basicProps);
ds_list_destroy(props);