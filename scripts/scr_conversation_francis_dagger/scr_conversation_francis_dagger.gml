/// scr_conversation_francis_dagger()
/// called by francis

var dagger = instance_create_depth(x,y,1,obj_hand_item_dagger);
dagger.numberOfSockets = 2;
insertGemIntoItem(makeGem(obj_gem_aquamarine,CRACKED),dagger);
addItemToInventory(dagger);
alert(dagger.name + " added to inventory",c_lime);