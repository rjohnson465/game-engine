/// staggerOrFlinch(attackObj,assailant,actualDamage)
/// @param attackObj
/// @param assailant
/// @param actualDamage

var attackObj = argument[0];
var assailant = argument[1];
var actualDamage = argument[2];

var percentOfHp = actualDamage / maxHp;
// maybe stagger
var chanceToStagger = (100-poise)/100;
randomize();
var rand = random_range(0,1);
if rand < chanceToStagger {
	if ds_map_size(preparingLimbs) != 0 {
		drawCombatText("Interrupt!",id);
	}
	if state != CombatantStates.Staggering {
		staggerFrame = 0;

		// stagger duration is (100-poise)% of weapon / attack staggerDuration
		var modifier = (100-poise)/100;
		if attackObj.attackData != noone {
			staggerDuration = attackObj.attackData.staggerDuration*modifier;
		} else if attackObj.isSpell {
			staggerDuration = attackObj.spell.staggerDuration;
		} else {
			staggerDuration = attackObj.weapon.staggerDuration;
		}

		staggerDirection = (assailant.facingDirection+360)%360;
		path_end();
		state = CombatantStates.Staggering;
	} else {
		staggerDuration += (percentOfHp*100);
	}
}
// if not stagger, then flinch
// all flinch values should be half of what a stagger value would have been
else {
	path_end();
	isFlinching = true;
	totalFlinchFrames = 5 + (.5*(percentOfHp*100)); 
	flinchDirection = (assailant.facingDirection+360)%360;				
}