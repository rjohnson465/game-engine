/// chooseRewardItem(item)
/// @param item

/// must be called by obj_item_reward


var item = argument[0];

audio_play_sound(item.soundDrop, 1, 0);

addItemToInventory(item);

var pos = ds_list_find_index(items, item);
ds_list_delete(items, pos);

isConfirming = false;
isAcceptingConfirmInput = false;
chosenRewardsCount++;