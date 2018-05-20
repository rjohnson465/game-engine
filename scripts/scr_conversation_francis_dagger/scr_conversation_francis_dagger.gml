/// scr_conversation_francis_dagger()
/// called by francis

var dagger = instance_create_depth(x,y,1,obj_hand_item_dagger);
addItemToInventory(dagger);
alert(dagger.name + " added to inventory",c_lime);