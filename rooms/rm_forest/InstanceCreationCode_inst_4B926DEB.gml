ei_unfairy_longswords_elements();
maxHp = 1;
hp = 1;
var key = makeKey("Basement Key", "key", spr_item_key, "Opens the door to the basement. Why do you want to go down there? Haven't you seen spooky movies?")
key.isMandatory = true;
ds_list_add(droppedItemsMandatory, key);