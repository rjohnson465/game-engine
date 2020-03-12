ei_unfairy_longswords_elements(FIRE, LIGHTNING);
maxHp = 200;
hp = 200;
name = "Unfairy Captain Ed";
var key = makeKey("Great-Lodge F2 Key", "key", spr_item_key, "Opens the door to the Fairy's Great-Lodge, Level 2. We really should have more than one copy of this thing.");
ds_list_add(droppedItemsMandatory, key);

chanceToDropHealthOrb = 1;
xpReward = 191;

hatSpriteIndex = spr_player_leathercap;
ds_map_replace(defenses,SLASH,10);
ds_map_replace(defenses,CRUSH,2);
ds_map_replace(defenses,PIERCE,7);

enemyKey = "cap";