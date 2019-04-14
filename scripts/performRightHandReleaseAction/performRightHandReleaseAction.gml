var leftHandItem = ds_map_find_value(equippedLimbItems,"l");
var rightHandItem = ds_map_find_value(equippedLimbItems,"r");

if global.gameManager.isMouseOverBelt exit;

if global.isWishing exit;
if global.isInteractingWithNpc exit;

var isFading = false;
with obj_fade {
	if instance_count > 0 {
		isFading = true;
	}
}
if isFading exit;
if hp <= 0 exit;
if rightHandItem.isRanged && rightHandItem.ammo < 1 && !rightHandItem.isTwoHanded {
	alert(rightHandItem.name + " is out of ammo", c_red);
	exit;
}

if !global.ui.isShowingMenus && !isFrozen && currentUsingSpell == noone && !isMouseInMenu {
	
	if leftHandItem.subType == HandItemTypes.Ranged && leftHandItem.isTwoHanded {
		
		if array_length_1d(leftHandItem.prepSounds) > 0 {
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
		state = CombatantStates.Idle;
	}
	
	else if  !leftHandItem.isTwoHanded
		&& rightHandItem.subType != HandItemTypes.Shield
		&& stamina > 0 
		&& (state != CombatantStates.Dodging && state != CombatantStates.Staggering)
		{
			// if recovering left hand weapon or if left hand not in use at all
			var isRightHandInUse = 
				ds_map_find_value(recoveringLimbs,"r") != undefined 
				|| ds_map_find_value(attackingLimbs,"r") != undefined;
			
			
			// have a will attack again map <limb><boolean> kvp's -- in Step event, at end of recover,
			// check the will attack again map. If it will attack again and there's enough stamina, do it
			if isRightHandInUse {
				ds_map_replace(attackAgain,"r",true);
			} else if ds_map_find_value(preparingLimbs,"r") == undefined {
				ds_map_replace(preparingLimbs,"r",1);
				
				ds_map_replace(prepFrames,"l",-1);
				ds_map_replace(prepFrameTotals,"l",0);
			}
			state = CombatantStates.Attacking;
	}
	// shields can only be in right hand
	else if rightHandItem && rightHandItem.subType == HandItemTypes.Shield {
		isShielding = false;
	}
	else if leftHandItem.isTwoHanded && !leftHandItem.isRanged {
		performLeftHandReleaseAction();
	}
}

hasIssuedAmmoOut = false;
