/// damageItem(item,amount)
/// @param item
/// @param amount

var item = argument[0];
var amount = argument[1];

item.durability -= amount;

// if below 33% durability, alert
if (item.durability/item.durabilityMax) < .33 && item.durability > 0 && !item.hasIssuedDurabilityWarning {
	alert(item.name + " at risk!",c_yellow);
	item.hasIssuedDurabilityWarning = true;
}

if item.durability <= 0 && !item.hasIssuedDurabilityObituary {
	alert(item.name + " broke!",c_red);
	item.hasIssuedDurabilityObituary = true;
}