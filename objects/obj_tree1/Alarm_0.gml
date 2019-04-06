alarm[0] = 7;
// no need to worry about draw transparency if not on player layer
// or very far from player
if (origLayer != global.player.layer || distance_to_object(global.player) > 1000) exit;

treeAlpha = 1;
with obj_combatant_parent {
	if other.origLayer == layer && (type == CombatantTypes.Player || (type == CombatantTypes.Enemy && showHp)) && distance_to_object(other) < 25 {
		other.treeAlpha = .66;
	}
}
