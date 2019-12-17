/// scr_elon_give_muskoxfood()

addItemToInventory(instance_create_depth(x,y,1,obj_item_muskoxfood));
audio_play_sound(snd_item_cloth, 1, 0);
alert("Elon gives you muskox food", c_yellow);

questStart(obj_quest_muskoxfeeder);