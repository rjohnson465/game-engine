global.ownerNpcName = "Randolph, the Red-Nosed Reindeeer";
var c1 = instance_create_depth(x,y,1,obj_conversation_parent);
c1.isUrgent = true;
c1.isRepeatable = false;
c1.name = "Reindeer Love (Completed)";

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Oh, you’ve done it, you hideous, wonderful man! Vixen will surely love me all the more for these nutritious snacks. Perhaps I’ll start a carrot farm, and our fauns will never need glasses.";
cs.sound = snd_conv_randolph_rile_randolph_1;
cs.speaker = obj_npc_randolph;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "I hope one day you too find love, even if it is fleeting, and bites you sharply, and leaves you cold and alone.";
cs.sound = snd_conv_randolph_rile_randolph_2;
cs.speaker = obj_npc_randolph;
cs.func = scr_reindeerlove_give_carrots;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "As promised -- here. Take this.";
cs.sound = snd_conv_randolph_rile_randolph_3;
cs.speaker = obj_npc_randolph;
cs.func = completeQuest;
cs.funcParam1 = obj_quest_reindeerlove;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "It’s my nose. Use it to melt away Mystic Ice, old relics of a time long past in Winter Wonderground.";
cs.sound = snd_conv_randolph_rile_randolph_4;
cs.speaker = obj_npc_randolph;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Be careful though -- there’s no telling what secrets you may find lurking beyond the ice...";
cs.sound = snd_conv_randolph_rile_randolph_5;
cs.speaker = obj_npc_randolph;
ds_list_add(c1.steps,cs);

return c1;