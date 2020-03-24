/// staggerOrFlinch(attackObj,assailant,actualDamage)
/// @param attackObj
/// @param assailant
/// @param actualDamage

var attackObj = argument[0];
var assailant = argument[1];
var actualDamage = argument[2];

/*
var percentOfHp = actualDamage / maxHp;
// maybe stagger
var chanceToStagger = (100-poise)/100;

// modify chance to stagger, depending on how heavy a hit was endured (based on staggerDuration)
var sd = 0;
if attackObj.attackData != noone sd = attackObj.attackData.staggerDuration;
else if attackObj.isSpell sd = attackObj.spell.staggerDuration;
else sd = attackObj.weapon.staggerDuration[attackObj.attackNumber-1];
var sdMod = sd/100;
chanceToStagger *= (1+sdMod); */

// determine stagger duration
var sd = 0;
if attackObj.attackData != noone sd = attackObj.attackData.staggerDuration;
else if attackObj.isSpell sd = attackObj.spell.staggerDuration;
else sd = attackObj.weapon.staggerDuration[attackObj.attackNumber-1];

// check if weapon has poise damage
if instance_exists(attackObj.weapon) && ds_map_find_value(attackObj.weapon.damagesPoise, attackObj.attackNumber -1) != undefined {
	var poiseDmg = ds_map_find_value(attackObj.weapon.damagesPoise, attackObj.attackNumber -1);
	poiseCurrent -= poiseDmg;
} else {
	// subtract actualDamage from poiseCurrent
	poiseCurrent -= actualDamage;
}

// randomize();
// var rand = random_range(0,1);
// if <condition met>, stagger
//if rand < chanceToStagger && sd >= 1 {
if (poiseCurrent <= 0 && !isShielding) && !cannotStagger {
	if ds_map_size(preparingLimbs) != 0 {
		drawCombatText("Interrupt!",id);
	}
	
	/*
	var modifier = ((100-poise)/100)*1.5;
	if modifier > 1 modifier = 1;
	*/
	if state != CombatantStates.Staggering {
		staggerFrame = 0;
		// staggerDuration = sd*modifier;
		staggerDuration = sd;
		staggerDirection = (assailant.facingDirection+360)%360;
		path_end();
		state = CombatantStates.Staggering;
	} else {
		
		/*modifier = ((100-poise)/100)*1.35;
		if modifier > 1 modifier = 1;
		*/
		// staggerDuration += sd*modifier;
		staggerDuration += sd;
		staggerDirection = (assailant.facingDirection+360)%360;
	}
}
// if not stagger, then flinch
// all flinch values should be half of what a stagger value would have been
else {
	path_end();
	isFlinching = true;
	// totalFlinchFrames = 5 + (.5*(percentOfHp*100)); 
	totalFlinchFrames = sd * .5;
	flinchDirection = (assailant.facingDirection+360)%360;				
}