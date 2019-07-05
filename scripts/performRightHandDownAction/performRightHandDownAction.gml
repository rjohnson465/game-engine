var leftHandItem = ds_map_find_value(equippedLimbItems,"l");
var rightHandItem = ds_map_find_value(equippedLimbItems,"r");

if global.isWishing exit;
if global.gameManager.isMouseOverBelt exit;
if global.isInteractingWithNpc exit;
if global.isTrading exit;
var isFading = false;
with obj_fade {
	if instance_count > 0 {
		isFading = true;
	}
}
if hp <= 0 exit;
if isFading exit;

with obj_npc_parent {
	if isInConversation {
		exit;
	}
}

if !isMouseInMenu && !isFrozen && !global.ui.isShowingMenus {

	// if using a 2h ranged weapon, holding right allows for aiming
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
			if array_length_1d(leftHandItem.prepSounds) > 0 && fallFrame == fallTotalFrames {
				var snd = leftHandItem.prepSounds[0];
				audio_play_sound_at(snd,x,y,depth,100,AUDIO_MAX_FALLOFF_DIST,1,0,1);
				//audio_play_sound(snd,1,0);
			}
			state = CombatantStates.Attacking;
		}
	}
}

if !global.ui.isShowingMenus && !isFrozen {
	if rightHandItem && rightHandItem.subType == HandItemTypes.Shield && stamina > 0 &&
		(state == CombatantStates.Idle || state == CombatantStates.Moving) && !isShielding {
		isShielding = true;
		global.owner = id;
		instance_create_depth(x,y,1,obj_shield_block);
	}
}