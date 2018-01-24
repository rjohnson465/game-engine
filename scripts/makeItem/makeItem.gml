/// makeItem(areaLevelAverage)
/// @param areaLevelAverage enemy/item level for the area

var level = argument[0];

var item = instance_create_depth(x,y,1,obj_hand_item_crossbow);
return item;