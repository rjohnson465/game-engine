if isLit exit;
with obj_attack {
	if place_meeting_layer(x,y, other) && weapon != noone && weapon.object_index == obj_hand_item_torch {
		with other {
			isLit = true;
			updatePersistentElementProperty(id, "isLit", true);
			audio_play_sound_at(snd_magic_fire_shoot,x,y,depth,100,300,1,0,1);
			global.owner = id;
			global.makeLightOnCreate = true;
			lightRadius = instance_create_depth(x,y,depth,obj_light_radius);
			with lightRadius {
				var floorNum = getLayerFloorNumber(layer);
				light_set_alpha(calculateLightRadiusAlphaLayer(floorNum));
			}
		}
	}
}