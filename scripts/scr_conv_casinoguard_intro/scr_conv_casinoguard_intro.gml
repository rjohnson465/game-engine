global.ownerNpcName = "Casino Guard";
var c1 = instance_create_depth(x,y,1,obj_conversation_parent);
c1.isUrgent = false;
c1.isRepeatable = false;
c1.name = "Casino Guard Intro";

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Halt! No one enters The Olive Branch Casino without proof of character!";
cs.sound = snd_conv_casinoguard_intro_casinoguard_1;
cs.speaker = obj_npc_casinoguard;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "What? If anyone’s a character, it’s you, your name is just “Casino Guard.”";
cs.sound = snd_conv_casinoguard_intro_gary_1;
cs.speaker = obj_player;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "NEVERTHELESS! A member in good standing with the casino must vouch for you to gain entrance.";
cs.sound = snd_conv_casinoguard_intro_casinoguard_2;
cs.speaker = obj_npc_casinoguard;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Are you kidding, you just let Tony in, that guy sent his weird lobster slug pet after me.";
cs.sound = snd_conv_casinoguard_intro_gary_2;
cs.speaker = obj_player;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "The Olive Branch Casino is Tony’s establishment. He is always welcome. You, on the other hand, are not, unless you can get a member to vouch for you. Good day!";
cs.sound = snd_conv_casinoguard_intro_casinoguard_3;
cs.speaker = obj_npc_casinoguard;
cs.func = questStart;
cs.funcParam1 = obj_quest_savingtheholidays;
ds_list_add(c1.steps,cs);

return c1;