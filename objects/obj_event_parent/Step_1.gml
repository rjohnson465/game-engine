// events fail when player dies
if isActive && !isFinished && instance_number(obj_player_death) > 0 {

	scr_event_fail(id);
}