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
	}
	
	switch currentProperty {
		case ItemProperties.HpRegen: {
			p.hpRegen += val;
			break;
		}
	}
	
	currentProperty = ds_map_find_next(props,currentProperty);
}