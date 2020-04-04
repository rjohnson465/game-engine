/// playerGetDodgeStaminaCost 


// current paradigm: @ 0% equip load, stamina cost is 5; @ 100% equip load, stamina cost is 10
with obj_player {
	var equipLoad = equipmentLoadCurrent / equipmentLoadMax;
	return (5*equipLoad) + 5;
}