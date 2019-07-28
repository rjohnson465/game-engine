if !isAlive exit;

if x < 0 exit;
if y < 0 exit;

if state == "Eat" {
	// summon minions succesfully
	if sprite_index != spr_enemy_ravebot_summon {
		sprite_index = spr_enemy_ravebot_summon;
		exit;
	}
	state = CombatantStates.AggroMelee;
	randomize()
	summonFrame = random_range(SUMMON_FREQ_MIN, SUMMON_FREQ_MAX);
	
	
	// make 2-3 ravey boys
	randomize();
	var numMinions = random_range(2, 3);
	for (var i = 0; i < numMinions; i++) {
		// try random places within 500px radius of ravebot
		randomize();
		var xo = random_range(-250, 250);
		randomize();
		var yo = random_range(-250, 250);
		
		var px = x + xo; var py = y + yo;
		
		// ensure minion is in acceptable place on dance floor
		while px < 350 || py < 290 || py > 1150 {
			randomize();
			var xo = random_range(-250, 250);
			randomize();
			var yo = random_range(-250, 250);
		
			var px = x + xo; var py = y + yo;
		}
		
		// if px > 50 && py > 50 && px < room_width - 50 && py < room_height - 50 {
		if true {
			var rbm = instance_create_layer(px, py, layer, obj_enemy_ravebot_minion);
			with rbm {
				jumpToNearestFreePoint(true, true);
			}
		}
	}
	
}