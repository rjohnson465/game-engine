/// damageItem(item,amount)
/// @param item
/// @param amount

var item = argument[0];
var amount = argument[1];

item.durability -= amount;

if item.durability <= 0 {
	alert(item.name + " broke!",c_red);
}