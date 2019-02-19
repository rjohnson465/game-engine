/// performChargeSpell

if global.isWishing exit;
if global.isInteractingWithNpc exit;

var isFading = false;
with obj_fade {
	if instance_count > 0 {
		isFading = true;
	}
}
if isFading exit;

var leftHandItem = ds_map_find_value(equippedLimbItems,"l");
var rightHandItem = ds_map_find_value(equippedLimbItems,"r");

if !isMouseInMenu {
	
	if currentSpell != noone && stamina > 0 && state != CombatantStates.Attacking {
	
		if	((rightHandItem.chargesMax > 0 && rightHandItem.charges > 0)  || (leftHandItem.chargesMax > 0 && leftHandItem.charges > 0))
		{
			currentUsingSpell = currentSpell;
			state = CombatantStates.Attacking;
			var snd = asset_get_index("snd_magic_"+currentSpellAttunement+"_charge");
			audio_play_sound(snd,1,1);
			currentSpellPrepSound = snd;
			justCastSpell = true;
		} else if !hasAlertedNoMagicCharges {
			alert("No magic charges",c_red);
			hasAlertedNoMagicCharges = true;
			alarm[1] = 60;
		}
	}
}