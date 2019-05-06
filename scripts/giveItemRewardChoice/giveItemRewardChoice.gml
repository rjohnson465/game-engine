/// giveItemRewardChoice(items)
/// @param items

var items = argument[0];

if instance_number(obj_item_reward) > 0 exit;

var ir = instance_create_depth(x, y, 1, obj_item_reward);
ir.items = items;