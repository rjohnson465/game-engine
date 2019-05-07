/// updateItemName(item)
/// @param item
/// update item name based on its stats and/or itemProperties map

var item = argument[0];

if object_is_ancestor(item.object_index, obj_hat_parent) && item.isSpecialHat exit;
updateItemNameBaseMods(item); // mods based on rarity
updateItemNameGems(item);
updateItemNameProperties(item);