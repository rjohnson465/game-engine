event_inherited();

isActive = ds_map_find_value(properties, "IsActive");

for (var i = 0; i < array_length_1d(associatedBridgeKeys); i++) {
	var bk = associatedBridgeKeys[i];
	with obj_ww_icebridge {
		if bKey == bk {
			ds_list_add(other.associatedBridges, id);
		}
	}
}

with obj_ww_icebridge {
	if arrayIncludes(other.associatedBridgeKeys, bKey) {
		lever = other;
		
		with other {
			for (var i = 0; i < ds_list_size(associatedBridges); i++) {
				var br = ds_list_find_value(associatedBridges, i);
				br.isActive = isActive;
				if isActive {
					br.image_xscale = br.xscale; br.image_yscale = br.yscale;
					with br {
						light_set_alpha(lightAlpha);
					}
				}
				else {
					br.image_xscale = 0; br.image_yscale = 0; 
					with br {
						light_set_alpha(0);
					}
				}
			}
			global.isPopulatingGrids = true;
		}
	}
}