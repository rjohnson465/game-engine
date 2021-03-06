var offHandItem = ds_map_find_value(equippedLimbItems,"l");
var mainHandItem = ds_map_find_value(equippedLimbItems,"r");

if global.gameManager.isMouseOverBelt exit;
if global.isTrading exit;
if global.isInteractingWithNpc exit;
var isMouseOverAttunement = false;
with obj_attunement {
	if position_meeting(mouse_x,mouse_y,id) {
		isMouseOverAttunement = true;
	}
}

with obj_npc_parent {
	if isInConversation {
		exit;
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

if mainHandItem.isRanged && mainHandItem.ammo < 1 && !mainHandItem.isTwoHanded {
	alert(mainHandItem.name + " out of ammo", c_red);
	exit;
}

if isMouseOverAttunement || isMouseOverHud exit;

if !global.ui.isShowingMenus && !isFrozen && currentUsingSpell == noone && !isMouseOverAttunement && !isMouseInMenu {

	if mainHandItem.subType == HandItemTypes.Ranged && mainHandItem.isTwoHanded {
		
		if array_length_1d(mainHandItem.prepSounds) > 0 {
			var snd = mainHandItem.prepSounds[0];
			if audio_is_playing(snd) {
				audio_stop_sound(snd);
			}
		}
		
		ds_map_delete(preparingLimbs,"r");
		ds_map_replace(prepFrames,"r",-1);
		ds_map_replace(prepFrameTotals,"r",0);
		ds_map_delete(attackingLimbs,"r");
		
		isReadyToFire = false;
		chargeFrame = -10;
		ds_map_delete(recoveringLimbs,"r");
		state = CombatantStates.Idle;
	}
	else if
		stamina > 0 &&
		(state != CombatantStates.Dodging && state != CombatantStates.Staggering)
		&& !isPhasing {
			isShielding = false;
			// if recovering left hand weapon or if left hand not in use at all
			var isRightHandInUse = 
				ds_map_find_value(recoveringLimbs,"r") != undefined 
				|| ds_map_find_value(attackingLimbs,"r") != undefined;
			
			// idea: have a will attack again map <handSide><boolean> kvp's -- in Step event, at end of recover,
			// check the will attack again map. If it will attack again and there's enough stamina, do it
			if isRightHandInUse {
				ds_map_replace(attackAgain,"r",true);
			} else if ds_map_find_value(preparingLimbs,"r") == undefined {
				ds_map_replace(preparingLimbs,"r",1);
			}
			state = CombatantStates.Attacking;
	}
}

hasIssuedAmmoOut = false;

