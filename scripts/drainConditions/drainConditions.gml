// conditionPercentages drain every step
// TODO Devin fix calculations for draining
var currentCondition = ds_map_find_first(conditionPercentages);
var size = ds_map_size(conditionPercentages);
for (var i = 0; i < size; i++){
	var conditionPercent = ds_map_find_value(conditionPercentages,currentCondition);
	
	// if condition is ice and it just dropped below 85 (coming from condition level 2, frozen), reset to condition level 1 (slow)
	if conditionPercent < 85 && currentCondition == ICE && ds_map_find_value(conditionLevels,currentCondition) == 2 {
			isFrozen = false;
			isSlowed = true;
			//functionalSpeed = round(.5*normalSpeed);
			ds_map_replace(conditionLevels,currentCondition,1);
	}
	
	// generally, if conditionPercent exceeds 95, condition level becomes 1
	// except for ice, in which condition level becomes 2 (frozen)
	if conditionPercent > 95 && currentCondition == ICE {
		ds_map_replace(conditionLevels,currentCondition,2);
		// freeze applied on a burning target, burn is removed
		if !isFrozen && isBurning {
			ds_map_replace(conditionPercentages,FIRE,0);
			isBurning = false;
		}
		isSlowed = false;
		isFrozen = true;
		functionalSpeed = 0;
	} else if conditionPercent > 95 {
		ds_map_replace(conditionLevels,currentCondition,1);
		switch currentCondition {
			case POISON: {
				isPoisoned = true; 
				lightRadiusColor = c_lime;
				//lightRadiusAlpha = .75;
				break;
			}
			case FIRE: {
				// if burn applied on a slowed or frozen target, slow / frozen is removed
				if !isBurning && (isSlowed || isFrozen) {
					ds_map_replace(conditionPercentages,ICE,0);
					isSlowed = false;
					isFrozen = false;
				}
				isBurning = true; 
				lightRadiusColor = c_orange;
				//lightRadiusAlpha = .75;
				break;
			}
			case LIGHTNING: {
				if !isShocked {
					// lower all defenses by a static (ha) amount
					var currentDefense = ds_map_find_first(defenses);
					for (var i = 0; i < ds_map_size(defenses); i++) {
						var defense = ds_map_find_value(defenses,currentDefense);
						ds_map_replace(defenses,currentDefense,defense-25);
						currentDefense = ds_map_find_next(defenses,currentDefense);
					}
				}
				isShocked = true; 				
				break;
			}
		}
	}
	
	// drain condition levels
	if conditionPercent > 0 {
		var decrementAmount = 1/3;
		var defense = ds_map_find_value(defenses,currentCondition);
		//decrementAmount += 1-abs((defense/100));
		decrementAmount = defense > 0 ? decrementAmount + 1-(defense/100) : decrementAmount - 1-(defense/100);
		if decrementAmount < 0 {
			decrementAmount = .2;
		}
		conditionPercent -= decrementAmount;
		ds_map_replace(conditionPercentages,currentCondition,conditionPercent);
	} if conditionPercent <= 0 {
		ds_map_replace(conditionPercentages,currentCondition,0);
		// set condition level to 0
		ds_map_replace(conditionLevels,currentCondition,0);
		switch currentCondition {
			case FIRE: {
				isBurning = false; 
				burnDamage = 0; 
				if lightRadiusColor == c_orange {
					lightRadiusColor = c_white;
					//lightRadiusAlpha = .25;
					lightRadiusSprite = spr_light_point;
				}
				break;
			}
			case ICE: {
				isSlowed = false; isFrozen = false; break;
			}
			case POISON: {
				isPoisoned = false; 
				poisonDamage = 0; 
				if lightRadiusColor == c_lime {
					lightRadiusColor = c_white;
					//lightRadiusAlpha = .25;
					lightRadiusSprite = spr_light_point;
				}
				break;
			}
			case LIGHTNING: {
				if isShocked {
					// reset all defenses to normal values
					var currentDefense = ds_map_find_first(defenses);
					for (var i = 0; i < ds_map_size(defenses); i++) {
						var defense = ds_map_find_value(defenses,currentDefense);
						ds_map_replace(defenses,currentDefense,defense+25);
						currentDefense = ds_map_find_next(defenses,currentDefense);
					}
				}
				isShocked = false; 
				break;
			}
		}
	}
	
	currentCondition = ds_map_find_next(conditionPercentages, currentCondition);
}