var offHandItem = ds_map_find_value(equippedLimbItems,"l");
var mainHandItem = ds_map_find_value(equippedLimbItems,"r");

if global.isWishing exit;
if global.isInteractingWithNpc exit;
if global.isTrading exit;
if global.gameManager.isMouseOverBelt exit;

var isFading = false;
with obj_fade {
	if instance_count > 0 {
		isFading = true;
	}
}
if isFading exit;
if hp <= 0 exit;

with obj_npc_parent {
	if isInConversation {
		exit;
	}
}

if !isMouseInMenu && !isFrozen && !global.ui.isShowingMenus {

	// if using a 2h ranged weapon, holding right allows for aiming
	if	mainHandItem.subType == HandItemTypes.Ranged && mainHandItem.isTwoHanded &&
		(state == CombatantStates.Idle || state == CombatantStates.Moving) {
		
		if mainHandItem.ammo < 1 {
			if !hasIssuedAmmoOut {
				alert(mainHandItem.name + " out of ammo",c_red);
			}
			hasIssuedAmmoOut = true;
			exit;
		}
		
		if	ds_map_find_value(recoverFrames,"r") == ds_map_find_value(recoverFrameTotals,"r")
			|| ds_map_find_value(recoveringLimbs,"r") == undefined
			{
			isShielding = false; 
			ds_map_replace(preparingLimbs,"r",1);
			if array_length_1d(mainHandItem.prepSounds) > 0 && fallFrame == fallTotalFrames {
				var snd = mainHandItem.prepSounds[0];
				audio_play_sound_at(snd,x,y,depth,100,AUDIO_MAX_FALLOFF_DIST,1,0,1);
				//audio_play_sound(snd,1,0);
			}
			state = CombatantStates.Attacking;
		}
	}
}