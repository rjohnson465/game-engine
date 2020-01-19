global.ownerNpcName = "Elon";
var c1 = instance_create_depth(x,y,1,obj_conversation_parent);
c1.isUrgent = false;
c1.isRepeatable = true;
c1.name = "The Abominable Curse";

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Have you seen fairies covered in ice out in the wild? They’ve nearly lost their minds, and will attack anything in sight.";
cs.sound = snd_conv_elon_curse_elon_1;
cs.speaker = obj_npc_elon;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "What happened to them?";
cs.sound = snd_conv_elon_curse_gary_1;
cs.speaker = obj_player;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "The Abominable Snowman’s power is growing; some fairies fall victim to its curse. Soon, they’ll become Abominable Minions, slaves to their master’s bidding.";
cs.sound = snd_conv_elon_curse_elon_2;
cs.speaker = obj_npc_elon;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "The best thing you can do is put them out of their misery. Sometimes death is truly the greatest gift.";
cs.sound = snd_conv_elon_curse_elon_3;
cs.speaker = obj_npc_elon;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Elon, what the heck, that’s so dark.";
cs.sound = snd_conv_elon_curse_gary_2;
cs.speaker = obj_player;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Yep. Man I could go for some hot chocolate right now.";
cs.sound = snd_conv_elon_curse_elon_4;
cs.speaker = obj_npc_elon;
ds_list_add(c1.steps,cs);

return c1;