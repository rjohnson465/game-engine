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

// modify chance to stagger, depending on how heavy a hit was endured (based on staggerDuration)
var sd = 0;
if attackObj.attackData != noone sd = attackObj.attackData.staggerDuration;
else if attackObj.isSpell sd = attackObj.spell.staggerDuration;
else sd = attackObj.weapon.staggerDuration[attackObj.attackNumber-1];
var sdMod = sd/100;
chanceToStagger *= (1+sdMod);

randomize();
var rand = random_range(0,1);
if rand < chanceToStagger {
	if ds_map_size(preparingLimbs) != 0 {
		drawCombatText("Interrupt!",id);
	}
	var modifier = ((100-poise)/100)*1.5;
	if modifier > 1 modifier = 1;
	if state != CombatantStates.Staggering {
		staggerFrame = 0;

		// stagger duration is (100-poise)% of weapon / attack staggerDuration
		
		/*if attackObj.attackData != noone {
			staggerDuration = attackObj.attackData.staggerDuration*modifier;
		} else if attackObj.isSpell {
			staggerDuration = attackObj.spell.staggerDuration;
		} else {
			var attackStaggerDuration = attackObj.weapon.staggerDuration[attackObj.attackNumber-1];
			staggerDuration = attackStaggerDuration*modifier;
		}*/
		staggerDuration = sd*modifier;

		staggerDirection = (assailant.facingDirection+360)%360;
		path_end();
		state = CombatantStates.Staggering;
	} else {
		modifier = ((100-poise)/100)*1.35;
		if modifier > 1 modifier = 1;
		staggerDuration += sd*modifier;
		staggerDirection = (assailant.facingDirection+360)%360;
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