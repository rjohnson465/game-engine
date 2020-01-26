/// playerGetDodgeStaminaCost 


// current paradigm: @ 0% equip load, stamina cost is 10; @ 100% equip load, stamina cost is 20
with obj_player {
	var equipLoad = equipmentLoadCurrent / equipmentLoadMax;
	return (10*equipLoad) + 10;
}