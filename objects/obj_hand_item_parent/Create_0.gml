event_inherited();

enum HandItemTypes {
	Shield,
	Melee,
	Ranged
}
type = "";
// Fast | Medium | Slow
weaponSpeed = "";

charges = 0;
totalCharges = 0;

// two handed weapons always held with "right hand" (on right side)
isTwoHanded = false;
// 0-1 min/max attack 1, 2-3 min/max attack 2, 3-4 min/max attack3
physicalDamageArray = [-1,-1,-1,-1,-1,-1]
// slash, pierce, crush
physicalDamageTypeArray = ["","",""];
staminaCostArray=[];

bonusMagic = 0;
bonusFire = 0;
bonusIce = 0;
bonusPoison = 0;
bonusLightning = 0;