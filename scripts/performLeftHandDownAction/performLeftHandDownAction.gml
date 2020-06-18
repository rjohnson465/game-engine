var offHandItem = ds_map_find_value(equippedLimbItems,"l");
var mainHandItem = ds_map_find_value(equippedLimbItems,"r");

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

	
}

if !global.ui.isShowingMenus && !isFrozen {
	if offHandItem && offHandItem.subType == HandItemTypes.Shield && stamina > 0 &&
		(state == CombatantStates.Idle || state == CombatantStates.Moving) && !isShielding {
		isShielding = true;
		global.owner = id;
		instance_create_depth(x,y,1,obj_shield_block);
	}
}