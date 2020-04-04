global.ownerNpcName = "Herbie";
var c1 = instance_create_depth(x,y,1,obj_conversation_parent);
c1.isUrgent = true;
c1.isRepeatable = false;
c1.name = "Herbie Intro";

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Gah! Oh, you’re not a wolf.";
cs.sound = snd_conv_herbie_intro_herbie_1;
cs.speaker = obj_npc_herbie;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Good sleuthing, you’ve really cracked that case.";
cs.sound = snd_conv_herbie_intro_gary_1;
cs.speaker = obj_player;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "I’m Herbie, the elf. I came out here to get wolf fangs for Mrs. Claus. If I make her a wolf-fang necklace, she’ll fall in love with me.";
cs.sound = snd_conv_herbie_intro_herbie_2;
cs.speaker = obj_npc_herbie;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Why do you say that?";
cs.sound = snd_conv_herbie_intro_gary_2;
cs.speaker = obj_player;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "She wants one to impress Krampus with.";
cs.sound = snd_conv_herbie_intro_herbie_3;
cs.speaker = obj_npc_herbie;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "So you think she’ll fall in love with you if you help her get with another guy?";
cs.sound = snd_conv_herbie_intro_gary_3;
cs.speaker = obj_player;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Yes.";
cs.sound = snd_conv_herbie_intro_herbie_4;
cs.speaker = obj_npc_herbie;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Genius.";
cs.sound = snd_conv_herbie_intro_gary_4;
cs.speaker = obj_player;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Look, the path back to her tavern is dangerous. If you help escort me, I’ll make sure you get rewarded. Deal?";
cs.sound = snd_conv_herbie_intro_herbie_5;
cs.speaker = obj_npc_herbie;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Talk to me again when you’re ready to begin the escort.";
cs.sound = snd_conv_herbie_intro_herbie_6;
cs.speaker = obj_npc_herbie;
cs.func = scr_savingherbie_herbie_found;
ds_list_add(c1.steps,cs);

return c1;