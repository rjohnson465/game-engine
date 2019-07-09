if origLayer >= global.player.layer {
	part_emitter_region(system,emitter,x-5,x+5,y-5,y+5,ps_shape_ellipse,ps_distr_gaussian);
	part_emitter_burst(system,emitter,particle, -2);
}

event_inherited();
var p = global.player;

var interactInputReceived = keyboard_check_released(ord("F"));
if gamepad_is_connected(global.player.gamePadIndex) {
	interactInputReceived = keyboard_check_released(ord("F")) || 
	(gamepad_button_check_pressed(global.player.gamePadIndex,gp_face1) && !global.ui.isShowingMenus)
}

var isInConvo = false;
with obj_npc_parent {
	if isInConversation isInConvo = true;
}

var angleToSconce = point_direction(p.x,p.y,x,y);
var isFacing = angleBetween(p.facingDirection-90,p.facingDirection+90,angleToSconce);

maybeAddOrRemoveFromInteractablesList(20);

if !isFacing {
	removeFromInteractablesList();
}

if isFacing && p.currentInteractableObject == id && origLayer == p.layer && interactInputReceived && p.isAlive && !global.isLooting && !isInConvo {
	var hasLamplight = false;
	var lampLightObj = noone;
	with obj_item_lamplight {
		if owner == global.player {
			hasLamplight = true;
			lampLightObj = id;
		}
	}
	if !isLit && hasLamplight {
		lightSconce(snd_magic_magic_shoot);
		if lampLightObj.count > 1 {
			lampLightObj.count--;
		} else {
			unequipItem(lampLightObj);
			if ds_list_find_index(global.player.inventory,lampLightObj) != -1 {
				ds_list_delete(global.player.inventory,ds_list_find_index(global.player.inventory,lampLightObj));
			}
			instance_destroy(lampLightObj, 1);
		}
	} else if !isLit {
		alert("No lamplight in inventory", c_red);
	}
	// extinguish flame
	else if isLit {
		isLit = false;
		extinguishSconce(snd_magic_magic_hit);
		// acquire lamplight
		var ll = instance_create_depth(x,y,1,obj_item_lamplight);
		addItemToInventory(ll);
	}
} 