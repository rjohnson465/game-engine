speed = .5*speed;
var currentSpell = ds_map_find_value(knownSpells,currentUsingSpell);
var MIDDLE_BUTTON_RELEASED = mouse_check_button_released(mb_middle);
if gamepad_is_connected(gamePadIndex) {
	MIDDLE_BUTTON_RELEASED = mouse_check_button_released(mb_middle) || 
	gamepad_button_check_released(gamePadIndex,gp_shoulderl);
}
			
if ds_map_size(attackingLimbs) == 0 && ds_map_size(preparingLimbs) == 0 && ds_map_size(recoveringLimbs) == 0 {
	ds_map_replace(prepFrameTotals,"l",currentSpell.castFrames);
	ds_map_replace(prepFrames,"l",0);
	ds_map_replace(preparingLimbs,"l",1);
}
			
// attack sequence 
if ds_map_find_value(prepFrames,"l") >= ds_map_find_value(prepFrameTotals,"l") || MIDDLE_BUTTON_RELEASED {
	cursor_sprite = -1;
	var prepFrame = ds_map_find_value(prepFrames,"l");
	var prepFrameTotal = ds_map_find_value(prepFrameTotals,"l");
	var percentCharged = prepFrame / prepFrameTotal;
				
	var chargeCost = round(percentCharged*currentSpell.maxChargeCost);
	// subtract charges from right hand item first
	if rightHandItem.charges > 0 {
		rightHandItem.charges -= chargeCost;
		if rightHandItem.charges < 0 {
			rightHandItem.charges = 0;
		}
	} else {
		leftHandItem.charges -= chargeCost;
		if leftHandItem.charges < 0 {
			leftHandItem.charges = 0;
		}
	}
				
	// only cast spell if charged enough to cost at least one magic charge
	if chargeCost > 0 {
		stamina -= percentCharged*currentSpell.staminaCost;
		for (var i = 0; i < currentSpell.numberOfProjectiles; i++) {
			global.owner = id;
			global.projectileNumber = i+1;
			global.percentCharged = percentCharged;
			global.limbKey = "l";
			//global.spellAttunement = spellAttunement;
			instance_create_depth(x,y,1,obj_attack);	
		}
	}
	ds_map_replace(prepFrames,"l",-1);
	ds_map_replace(prepFrameTotals,"l",0);
	ds_map_delete(preparingLimbs,"l");
	currentUsingSpell = noone;
	state = CombatantStates.Idle;
} else {
	ds_map_replace(prepFrames,"l",ds_map_find_value(prepFrames,"l")+1);
}