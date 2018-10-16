/// appraiseItemForRepair(item)
/// @param item
var item = argument[0];

// 100 gold / durability point + (.5*itemValue)
var amount = item.durabilityMax*100;
amount += (.5*item.value);
return amount;