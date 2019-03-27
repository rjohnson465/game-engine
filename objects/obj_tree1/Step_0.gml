var isCombatantUnderTree = false;
with obj_combatant_parent {
	if other.origLayer == layer && (type == CombatantTypes.Player || (type == CombatantTypes.Enemy && showHp)) && distance_to_object(other) < 25 {
		isCombatantUnderTree = true;
	}
}

//if (distance_to_object(obj_player) < 25 && origLayer == global.player.layer) {
if isCombatantUnderTree {
	treeAlpha = .66;
} 


else {
	treeAlpha = 1;
}