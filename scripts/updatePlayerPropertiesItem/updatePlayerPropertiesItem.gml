/// updatePlayerPropertiesItem(item, isEquipping)
/// @param item
/// @param isEquipping 

var item = argument[0];
var isEquipping = argument[1];
var props = item.itemProperties;
var p = global.player;

var currentProperty = ds_map_find_first(props);
for (var i = 0; i < ds_map_size(props); i++) {
	
	var val = ds_map_find_value(props,currentProperty);
	if !is_array(val) {
		// if unequipping, subtract val from relevant player property
		val = isEquipping ? val : val*-1;
		updatePlayerProperty(currentProperty,val,1);
	}
	// TODO account for macro mapped stuff (i.e. critical chances)
	else {
		// val is array
		var macro = val[0];
		val = isEquipping ? val[1] : -1*(val[1]); // the number part
		updatePlayerProperty(currentProperty,val,1,macro);
	}
	
	
	currentProperty = ds_map_find_next(props,currentProperty);
}