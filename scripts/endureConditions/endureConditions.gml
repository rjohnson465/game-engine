// account for any currently active conditions (slowed/frozen, burning, poisoned, electrified)
var currentCondition = ds_map_find_first(conditionLevels);
var size = ds_map_size(conditionLevels);
for (var i = 0; i < size; i++){
	var conditionLevel = ds_map_find_value(conditionLevels,currentCondition);
	var conditionPercent = ds_map_find_value(conditionPercentages,currentCondition);
	var defense = ds_map_find_value(defenses,currentCondition);
	
	// particle effects for conditions
	if conditionLevel > 0 && currentCondition != MAGIC && currentCondition != PHYSICAL {
		var condParticlesExist = false;
		var c = currentCondition;
		var o = id;
		with (obj_condition_particles) {
			if condition == c && owner == o {
				condParticlesExist = true;
			}
		}
		if !condParticlesExist {
			global.condition = currentCondition;
			global.owner = id;
			instance_create_depth(x,y,1,obj_condition_particles);
		}
	}
	
	// set back old properties when conditions expire
	if conditionLevel <= 0 {
		switch currentCondition {
			case ICE: {
				functionalSpeed = normalSpeed;
			}
		}
	}
	else {
		switch currentCondition {
			case ICE: {
				// slowed
				if conditionLevel == 1 {
					functionalSpeed = (1-(conditionPercent/100))*normalSpeed;
				}
				// frozen
				else if conditionLevel == 2{
					//functionalSpeed = 0;
				}
				break;
			}
			// burning
			case FIRE: {
				// burn damage taken every 2 seconds by default
				// if fire defense is positive, defense% of 60 is added to burn frames
				burnFrames = (defense >= 0) ? burnFrames + burnFrames*(defense/100) : burnFrames - burnFrames*(defense/100);
				if burnFrame >= burnFrames {

					var originalBurnDamage = burnDamage;
					if burnDamage > hp {
						burnDamage = hp;
					}
					hp -= burnDamage;
					//if type != CombatantTypes.Player {
						global.damageAmount = burnDamage;
						global.victim = id;
						global.healingSustained = 0;
						instance_create_depth(x,y,1,obj_damage);
					//}
					// diminishes every pulse
					// TODO math major DEVIN
					burnDamage = originalBurnDamage;
					burnDamage = defense >= 0 ? 
						burnDamage - ((.25*burnDamage)-((.25*burnDamage)*(defense/100))) : 
						burnDamage - ((.25*burnDamage)+((.25*burnDamage)*(defense/100)));
					if burnDamage < 1 {
						burnDamage = 1;
					}
					burnFrame = 0;
				}
				burnFrame++;
				break;
			}
			// poisoned
			case POISON: {
				// poison damage taken every 2 seconds by default 
				// if poison defense is poistive, defense% of 60 is added to burn frames. if less, it is subtracted
				poisonFrames = (defense >= 0) ? poisonFrames + poisonFrames*(defense/100) : poisonFrames - poisonFrames*(defense/100);
				if poisonFrame >= poisonFrames {
					poisonDamage = defense >= 0 ? (poisonDamage - poisonDamage*(defense/100)) : (poisonDamage + poisonDamage*(defense/100));
					var originalPoisonDamage = poisonDamage;
					if poisonDamage > hp {
						poisonDamage = hp;
					}
					hp -= poisonDamage;

					global.damageAmount = poisonDamage;
					global.victim = id;
					global.healingSustained = 0;
					instance_create_depth(x,y,1,obj_damage);
					// builds every pulse
					// TODO math major DEVIN
					poisonDamage = originalPoisonDamage;
					poisonDamage = defense >= 0 ? 
						poisonDamage + ((.25*poisonDamage)-((.25*poisonDamage)*(defense/100))) : 
						poisonDamage + ((.25*poisonDamage)+((.25*poisonDamage)*(defense/100)));
					poisonFrame = 0;
				}
				poisonFrame++;
				break;
			}
			case LIGHTNING: {
				// shock lowers defenses; this is handled just once, when lightning percent is set to 100; i.e. not here
			}
		}
	}
	
	currentCondition = ds_map_find_next(conditionPercentages, currentCondition);
}