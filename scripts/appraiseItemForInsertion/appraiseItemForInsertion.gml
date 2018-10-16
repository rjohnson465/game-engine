/// appraiseItemForInsertion(item, gem) 
/// @param item
/// @param gem
var item = argument[0];
var gem = argument[1];

/*
var gemCopy = instance_copy(gem);
insertGemIntoItem(gemCopy, item, 0);
var baseAmount = appraiseItem(item);
insertGemIntoItem(gemCopy, item, 1);
*/

var baseAmount = item.value + gem.value;
return baseAmount * 1.25; // 25% premium for gem insertion