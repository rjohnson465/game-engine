with obj_npc_tony {
	facingDirection = direction;
	if other.setTonysPath {
		if distance_to_object(obj_npc_casinoguard) < 32 {
			instance_destroy(id, 1);
		}
	}
}

with obj_player {
	if other.setTonysPath {
		facingDirection = direction;
		if instance_number(obj_npc_tony) == 0 {
			path_end();
			var cg = instance_nearest(x, y, obj_npc_casinoguard);
			cg.isInteractingWithPlayer = true;
			var conv = scr_conv_casinoguard_intro();
			with cg {
				startConversation(conv); 
			}
			instance_destroy(other, 1);
		} else if path_index < 0 {
			var cg = instance_nearest(x, y, obj_npc_casinoguard);
			var p = mp_potential_path(path, cg.x, cg.y, 4, 4, false);
			path_start(path, 7, path_action_stop, true);
		}
	} 
}