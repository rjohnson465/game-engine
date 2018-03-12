// iterate over the preparing limbs to see if an attack should fire
// TODO what about non humanoid attackers or attacks that do not use limbs?

var attackNumber = currentMeleeAttack == noone ? currentRangedAttack : currentMeleeAttack;
if attackNumber == noone exit;
var isRanged = currentRangedAttack != noone;

var currentPreparingLimbKey = ds_map_find_first(preparingLimbs); // limbKey
for (var i = 0; i < ds_map_size(preparingLimbs); i++) {
	var prepFrame = ds_map_find_value(prepFrames,currentPreparingLimbKey);
	var totalPrepFrames = ds_map_find_value(prepFrameTotals,currentPreparingLimbKey);
				
	// stop preparing, begin attacking
	if prepFrame >= totalPrepFrames-1 {
					
		// find attack data object for this attack to get stamina cost
		var limb = findLimb(id,currentPreparingLimbKey);
		var attackInChain = ds_map_find_value(preparingLimbs,currentPreparingLimbKey);
		var attackData = noone;
		if !isRanged {
			var attackChain = meleeAttacks[attackNumber-1];
			attackData = attackChain[attackInChain-1];
		} else {
			var attackChain = rangedAttacks[attackNumber-1];
			attackData = attackChain[attackInChain-1];
		}
		stamina -= attackData.staminaCost;
					
		// update data structures
		ds_map_replace(prepFrames,currentPreparingLimbKey,-1);
		ds_map_replace(prepFrameTotals,currentPreparingLimbKey,0);
		ds_map_delete(preparingLimbs,currentPreparingLimbKey);
		ds_map_replace(attackingLimbs,currentPreparingLimbKey,attackInChain);
					
		// create attack object
		global.owner = id; // passed as param to attackObj
		global.limbKey = currentPreparingLimbKey;
		var attackObj = instance_create_depth(x,y,1,obj_attack);
					
		hasCalculatedNextAttack = false;
	} else {
		// increment through frames for attack prep
		if isSlowed {
			ds_map_replace(prepFrames,currentPreparingLimbKey,prepFrame+.5);
		} else {
			ds_map_replace(prepFrames,currentPreparingLimbKey,prepFrame+1);
		}
	}
	currentPreparingLimbKey = ds_map_find_next(preparingLimbs,currentPreparingLimbKey);
}