var offHandItem = ds_map_find_value(equippedLimbItems,"l");
var mainHandItem = ds_map_find_value(equippedLimbItems,"r");

if global.gameManager.isMouseOverBelt exit;

if global.isWishing exit;
if global.isInteractingWithNpc exit;
if global.isTrading exit;

with obj_npc_parent {
	if isInConversation {
		exit;
	}
}

var isFading = false;
with obj_fade {
	if instance_count > 0 {
		isFading = true;
	}
}
if isFading exit;
if hp <= 0 exit;
if offHandItem.isRanged && offHandItem.ammo < 1 && !offHandItem.isTwoHanded {
	alert(offHandItem.name + " out of ammo", c_red);
	exit;
}

if !global.ui.isShowingMenus && !isFrozen && currentUsingSpell == noone && !isMouseInMenu {
	
	if mainHandItem.subType == HandItemTypes.Ranged && mainHandItem.isTwoHanded {
		
		//if array_length_1d(mainHandItem.prepSounds) > 0 {
		//	var snd = mainHandItem.prepSounds[0];
		//	if audio_is_playing(snd) {
		//		audio_stop_sound(snd);
		//	}
		//}
		
		//ds_map_delete(preparingLimbs,"r");
		//ds_map_replace(prepFrames,"r",-1);
		//ds_map_replace(prepFrameTotals,"r",0);
		//ds_map_delete(attackingLimbs,"r");
		
		//isReadyToFire = false;
		//chargeFrame = -10;
		//ds_map_delete(recoveringLimbs,"r");
		//state = CombatantStates.Idle;
	}
	
	else if  !mainHandItem.isTwoHanded
		&& offHandItem.subType != HandItemTypes.Shield
		&& stamina > 0 
		&& (state != CombatantStates.Dodging && state != CombatantStates.Staggering)
		{
			// if recovering left hand weapon or if left hand not in use at all
			var isLeftHandInUse = 
				ds_map_find_value(recoveringLimbs,"l") != undefined 
				|| ds_map_find_value(attackingLimbs,"l") != undefined;
			
			
			// have a will attack again map <limb><boolean> kvp's -- in Step event, at end of recover,
			// check the will attack again map. If it will attack again and there's enough stamina, do it
			if isLeftHandInUse {
				ds_map_replace(attackAgain,"l",true);
			} else if ds_map_find_value(preparingLimbs,"l") == undefined {
				ds_map_replace(preparingLimbs,"l",1);
				
				ds_map_replace(prepFrames,"l",-1);
				ds_map_replace(prepFrameTotals,"l",0);
			}
			state = CombatantStates.Attacking;
	}
	// shields can only be in off hand
	else if offHandItem && offHandItem.subType == HandItemTypes.Shield {
		isShielding = false;
	}
	else if mainHandItem.isTwoHanded && !mainHandItem.isRanged {
		// performRightHandReleaseAction();
	}
}

hasIssuedAmmoOut = false;
