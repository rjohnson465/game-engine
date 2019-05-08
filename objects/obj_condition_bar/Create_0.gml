owner = global.owner;
condition = global.condition;

isDestroying = false;
// if there is already a bar tracking this condition, kill this bar
with obj_condition_bar {
	if id == other continue;
	if owner == other.owner && condition == other.condition {
		instance_destroy(other, 1);
		other.isDestroying = true;
	}
}

if !isDestroying {
	global.conditionBarCount++;
}
conditionBarNumber = global.conditionBarCount;