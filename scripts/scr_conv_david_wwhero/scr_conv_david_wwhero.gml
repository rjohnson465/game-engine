global.ownerNpcName = "David";
var c1 = instance_create_depth(x,y,1,obj_conversation_parent);
c1.isUrgent = false;
c1.isRepeatable = true;
c1.name = "The Hero of Winter Wonderground";

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Gary, my dear boy, good to see you! Thanks again for freeing us from the Abominable Snowman’s wrath!";
cs.sound = snd_conv_david_wwhero_david_1;
cs.speaker = obj_npc_david;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Go use that voucher and gamble your heart out in my name, okay? I think my wife’s onto me.";
cs.sound = snd_conv_david_wwhero_david_2;
cs.speaker = obj_npc_david;
ds_list_add(c1.steps,cs);

return c1;