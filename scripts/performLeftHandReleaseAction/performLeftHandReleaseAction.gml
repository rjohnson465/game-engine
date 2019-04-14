var leftHandItem = ds_map_find_value(equippedLimbItems,"l");
var rightHandItem = ds_map_find_value(equippedLimbItems,"r");

if global.gameManager.isMouseOverBelt exit;

var isMouseOverAttunement = false;
with obj_attunement {
	if position_meeting(mouse_x,mouse_y,id) {
		isMouseOverAttunement = true;
	}
}

var isMouseOverHud = false;
with obj_hud_parent {
	if position_meeting(mouse_x,mouse_y,id) {
		isMouseOverHud = true;
	}
}

var isFading = false;
with obj_fade {
	if instance_count > 0 {
		isFading = true;
	}
}
if isFading exit;

if global.isLooting && !gamepad_is_connected(gamePadIndex) exit;

if global.isWishing exit;
if global.isInteractingWithNpc exit;
if hp <= 0 exit;

if leftHandItem.isRanged && leftHandItem.ammo < 1 && !leftHandItem.isTwoHanded {
	alert(leftHandItem.name + " is out of ammo", c_red);
	exit;
}

if isMouseOverAttunement || isMouseOverHud exit;

if !global.ui.isShowingMenus && !isFrozen && currentUsingSpell == noone && !isMouseOverAttunement && !isMouseInMenu {

	if leftHandItem.subType == HandItemTypes.Ranged && leftHandItem.isTwoHanded {
		
		/*if array_length_1d(leftHandItem.prepSounds) > 0 {
			var snd = leftHandItem.prepSounds[0];
			if audio_is_playing(snd) {
				audio_stop_sound(snd);
			}
		}
		
		ds_map_delete(preparingLimbs,"l");
		ds_map_replace(prepFrames,"l",-1);
		ds_map_replace(prepFrameTotals,"l",0);
		ds_map_delete(attackingLimbs,"l");
		
		isReadyToFire = false;
		chargeFrame = -10;
		ds_map_delete(recoveringLimbs,"l");
		state = CombatantStates.Idle;*/
	}
	else if
		stamina > 0 &&
		(state != CombatantStates.Dodging && state != CombatantStates.Staggering)
		&& !isPhasing {
			isShielding = false;
			// if recovering left hand weapon or if left hand not in use at all
			var isLeftHandInUse = 
				ds_map_find_value(recoveringLimbs,"l") != undefined 
				|| ds_map_find_value(attackingLimbs,"l") != undefined;
			
			// idea: have a will attack again map <handSide><boolean> kvp's -- in Step event, at end of recover,
			// check the will attack again map. If it will attack again and there's enough stamina, do it
			if isLeftHandInUse {
				ds_map_replace(attackAgain,"l",true);
			} else if ds_map_find_value(preparingLimbs,"l") == undefined {
				ds_map_replace(preparingLimbs,"l",1);
			}
			state = CombatantStates.Attacking;
	}
}

hasIssuedAmmoOut = false;

