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
		}
	}
}