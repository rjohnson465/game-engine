if room == game_menu {
	exit;
}
if object_is_ancestor(rightHandItem.object_index, obj_shield_parent)
|| (leftHandItem.isRanged && leftHandItem.isTwoHanded)
{
	performRightHandReleaseAction();
}

/*if rightHandItem && rightHandItem.subType == HandItemTypes.Shield {
		isShielding = false;
	}