var leftHandItem = ds_map_find_value(equippedLimbItems,"l");
var rightHandItem = ds_map_find_value(equippedLimbItems,"r");

if global.isWishing exit;
if global.isInteractingWithNpc exit;

var isFading = false;
with obj_fade {
	if instance_count > 0 {
		isFading = true;
	}
}
if isFading exit;

if !isMouseInMenu && !isFrozen && !global.ui.isShowingMenus {

	// if using a 2h ranged weapon, holding left allows for aiming
	if	leftHandItem.subType == HandItemTypes.Ranged && leftHandItem.isTwoHanded &&
		(state == CombatantStates.Idle || state == CombatantStates.Moving) {
		
		if leftHandItem.ammo < 1 {
			if !hasIssuedAmmoOut {
				alert(leftHandItem.name + " out of ammo",c_red);
			}
			hasIssuedAmmoOut = true;
			exit;
		}
		
		if	ds_map_find_value(recoverFrames,"l") == ds_map_find_value(recoverFrameTotals,"l")
			|| ds_map_find_value(recoveringLimbs,"l") == undefined
			{
			isShielding = false; 
			ds_map_replace(preparingLimbs,"l",1);
			if array_length_1d(leftHandItem.prepSounds) > 0 {
				var snd = leftHandItem.prepSounds[0];
				audio_play_sound_at(snd,x,y,depth,100,300,1,0,1);
			}
			state = CombatantStates.Attacking;
		}
	}
}