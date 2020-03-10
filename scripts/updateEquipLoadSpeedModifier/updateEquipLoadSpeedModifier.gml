/// updateEquipLoadSpeedModifier()

// update the equipload speed modifier
var eqPerc = (global.player.equipmentLoadCurrent / global.player.equipmentLoadMax) * 100;
	
// at 0% equip load, modifier is 1.25, at 100% it's .5
global.player.equipLoadSpeedModifier  = (eqPerc * (-.005)) + 1.25;

// get less dodgeFrames with greater equip load
// totalDodgeFrames = sprite_get_number(asset_get_index("spr_"+global.player.spriteString+"_dodge"));

// at 0% equip load, have all 12 dodgeFrames
// at 100% equip load, have only 6
// global.player.totalDodgeFrames = ((-3/50)*eqPerc) + 12;

// new at 0%, 15, @ 100% 8
global.player.totalDodgeFrames = ((-7/100)*eqPerc) + 15;

var a = 3;