global.ownerNpcName = "Randolph, the Red-Nosed Reindeeer";
var c1 = instance_create_depth(x,y,1,obj_conversation_parent);
c1.isUrgent = true;
c1.isRepeatable = false;
c1.name = "Reindeer Love";

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Wow, a red-nosed reindeer, you must be --";
cs.sound = snd_conv_randolph_rils_gary_1;
cs.speaker = obj_player;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Randolph! My name is Randolph. Speak no other name.";
cs.sound = snd_conv_randolph_rils_randolph_1;
cs.speaker = obj_npc_randolph;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "What? Why?";
cs.sound = snd_conv_randolph_rils_gary_2;
cs.speaker = obj_player;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Are you familiar with the concept of “public domain” or “copyright law?”";
cs.sound = snd_conv_randolph_rils_randolph_2;
cs.speaker = obj_npc_randolph;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "No, I’m a mystical creature / alcoholic.";
cs.sound = snd_conv_randolph_rils_gary_3;
cs.speaker = obj_player;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Ah, to live so simply. What must it be like?";
cs.sound = snd_conv_randolph_rils_randolph_3;
cs.speaker = obj_npc_randolph;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "OK, you’re one of Santa’s flying reindeer, how hard can your life be?";
cs.sound = snd_conv_randolph_rils_gary_4;
cs.speaker = obj_player;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "If you must know, my dear, simple friend, I am in love. Yes, love. How horrible! How wonderful! How everything!";
cs.sound = snd_conv_randolph_rils_randolph_4;
cs.speaker = obj_npc_randolph;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Have you ever been in love? From your unkind brow and homely eyes, I’d imagine you have not, and never will, experience love’s embrace. But if by some miracle, a hag falls for you, you will perhaps understand my warmth and pain.";
cs.sound = snd_conv_randolph_rils_randolph_5;
cs.speaker = obj_npc_randolph;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Yeah, I’m gonna bounce";
cs.sound = snd_conv_randolph_rils_gary_5;
cs.speaker = obj_player;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Wait, ugly sir! Before you do; my beloved, Vixen… she yearns for a pleasure I cannot give.";
cs.sound = snd_conv_randolph_rils_randolph_6;
cs.speaker = obj_npc_randolph;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "OK, let me stop you right there…";
cs.sound = snd_conv_randolph_rils_gary_6;
cs.speaker = obj_player;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Carrots, my man, carrots. They disappeared from these lands, long ago. But if you can find me some, it will ring our love anew, and I will be in your debt.";
cs.sound = snd_conv_randolph_rils_randolph_7;
cs.speaker = obj_npc_randolph;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Please, find me carrots, and I will give you something to help light your path, wherever it may lead.";
cs.sound = snd_conv_randolph_rils_randolph_8;
cs.speaker = obj_npc_randolph;
cs.func = questStart;
cs.funcParam1 = obj_quest_reindeerlove;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "";
cs.sound = noone;
cs.speaker = obj_npc_randolph;
cs.func = scr_reindeerlove_activation;
ds_list_add(c1.steps,cs);

return c1;