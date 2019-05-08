//if !isSlowed && !isPoisoned && !isHexed && !isFrozen && !isBurning && !isShocked exit;
// conditionPercentages drain every step
if type != CombatantTypes.Player && (distance_to_object(obj_player)) > 1000 && state == CombatantStates.Idle exit;
// TODO Devin fix calculations for draining
var currentCondition = ds_map_find_first(conditionPercentages);
var size = ds_map_size(conditionPercentages);
var conditionsExist = false;
for (var i = 0; i < size; i++) {
	var conditionPercent = ds_map_find_value(conditionPercentages,currentCondition);
	
	if conditionPercent > 0 {
		conditionsExist = true;
	}
	
	// if condition is ice and it just dropped below 85 (coming from condition level 2, frozen), reset to condition level 1 (slow)
	if conditionPercent < 85 && currentCondition == ICE && ds_map_find_value(conditionLevels,currentCondition) == 2 {
			isFrozen = false;
			isSlowed = true;
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
	} else if conditionPercent > 0 {
		ds_map_replace(conditionLevels,currentCondition,1);
		switch currentCondition {
			case ICE: {
				// if freeze applied on a burning target, burn is removed
				if (!isSlowed && !isFrozen) && isBurning {
					ds_map_replace(conditionPercentages,FIRE,0);
					isBurning = false;
				}
				ds_map_replace(conditionLevels,currentCondition,1);
				isFrozen = false;
				isSlowed = true;
				break;
			}
			case MAGIC: {
				isHexed = true;
				lightRadiusColor = c_aqua;
				break;
			}
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
					functionalSpeed = normalSpeed;
				}
				isBurning = true; 
				lightRadiusColor = C_FIRELIGHT;
				//lightRadiusAlpha = .75;
				break;
			}
			case LIGHTNING: {
				if !isShocked {
					// lower all defenses by a static (ha) amount
					var currentDefense = ds_map_find_first(defenses);
					for (var i = 0; i < ds_map_size(defenses); i++) {
						if arrayIncludes(global.ALL_ELEMENTS,currentDefense) {
							var defense = ds_map_find_value(defenses,currentDefense);
							// don't lower lightning defense
							if currentDefense != LIGHTNING {
								ds_map_replace(defenses,currentDefense,defense-25);
							}
						}
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
		var decrementAmount = .2;		
		// if this is not an elemental condition (i.e. defense boost from elixir), decrement slower
		if !arrayIncludes(global.ALL_ELEMENTS, currentCondition) {
			decrementAmount = .05;
		} else {
			var defense = ds_map_find_value(defenses,currentCondition);
			decrementAmount = (.0067*defense)+.2;
			if decrementAmount < 0 {
				decrementAmount = .1;
			}
		}

		conditionPercent -= decrementAmount;
		ds_map_replace(conditionPercentages,currentCondition,conditionPercent);
	} if conditionPercent <= 0 {
		ds_map_replace(conditionPercentages,currentCondition,0);
		// set condition level to 0
		ds_map_replace(conditionLevels,currentCondition,0);
		// stop the emitter
		var sndId = ds_map_find_value(conditionSoundsMap, currentCondition);
		if (sndId != noone) {
			var emitter = ds_map_find_value(conditionsEmittersMap, currentCondition);
				if emitter != undefined {
				audio_emitter_gain(emitter, 0);
				audio_stop_sound(sndId);
			}
			ds_map_replace(conditionSoundsMap, currentCondition, noone);
		}
		switch currentCondition {
			case FIRE: {
				isBurning = false; 
				burnDamage = 0; 
				if lightRadiusColor != c_white {
					lightRadiusColor = c_white;
					lightRadiusScale = normalLightRadiusScale;
					lightRadiusSprite = spr_light_point;
				}
				break;
			}
			case ICE: {
				isSlowed = false; isFrozen = false; 
				slowedSpeedModifier = 1;
				break;
			}
			case MAGIC: {
				isHexed = false; 
				hexedDamageModifier = 1;
				if lightRadiusColor == c_aqua {
					lightRadiusColor = c_white;
				}
				break;
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
						if arrayIncludes(global.ALL_ELEMENTS,currentDefense) {
							var defense = ds_map_find_value(defenses,currentDefense);
							// don't lower lightning defense
							if currentDefense != LIGHTNING {
								ds_map_replace(defenses,currentDefense,defense+25);
							}
						}
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

if !conditionsExist {
	lightRadiusColor = c_white;
}