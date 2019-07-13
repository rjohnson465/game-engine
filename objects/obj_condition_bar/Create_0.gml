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

// conditionBarNumber = global.conditionBarCount;
conditionBarNumber = noone;

var maxPossible = instance_number(obj_condition_bar);

for (var i = 1; i <= maxPossible; i++) {
	with obj_condition_bar {
		if other.conditionBarNumber != noone continue;
		if id == other {
			continue;
		}
		if conditionBarNumber == i {
			continue;
		}
		else {
			other.conditionBarNumber = i;
		}
	}
}

if conditionBarNumber == noone {
	conditionBarNumber = 1;
}


var a = 3;