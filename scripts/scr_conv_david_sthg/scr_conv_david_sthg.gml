global.ownerNpcName = "David";
var c1 = instance_create_depth(x,y,1,obj_conversation_parent);
c1.isUrgent = true;
c1.isRepeatable = false;
c1.name = "Saving the Holidays (Gazebo)";

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Oh hi, guys. Have you just been standing here staring at each other ‘til I arrived.";
cs.sound = snd_conv_david_sthg_gary_1;
cs.speaker = obj_npc_david;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Yes. Miser.";
cs.sound = snd_conv_david_sthg_santa_1;
cs.speaker = obj_npc_santa;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Shmendrik";
cs.sound = snd_conv_david_sthg_david_1;
cs.speaker = obj_npc_david;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Okay, let’s all settle down and remember what’s really important: murdering a giant monster I know nothing about so I can go gambling.";
cs.sound = snd_conv_david_sthg_gary_2;
cs.speaker = obj_player;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Yes, of course. I won’t have the Abominable Snowman bothering my poor reindeer anymore.";
cs.sound = snd_conv_david_sthg_santa_2;
cs.speaker = obj_npc_santa;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Nor will I have his terrible minions terrorizing my people, and blowing out our menorahs. Okay, fine. Santa, today, we will put aside our differences, and do what we must for the good of Winter Wonderground. Tomorrow, we can go back to hating each other.";
cs.sound = snd_conv_david_sthg_david_2;
cs.speaker = obj_npc_david;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "That’s the spirit! Okay, what do we need to do the spell?";
cs.sound = snd_conv_david_sthg_gary_3;
cs.speaker = obj_player;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "We… David and I… must…";
cs.sound = snd_conv_david_sthg_santa_3;
cs.speaker = obj_npc_santa;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "We must lock eyes, and feel a genuine sense of mutual respect or understanding.";
cs.sound = snd_conv_david_sthg_david_3;
cs.speaker = obj_npc_david;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Yeah that should go well. Alright, give it a try, I guess. …………";
cs.sound = snd_conv_david_sthg_gary_4;
cs.speaker = obj_player;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Anything happening?";
cs.sound = snd_conv_david_sthg_gary_5;
cs.speaker = obj_player;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "No, it’s impossible. There’s nothing we can agree on.";
cs.sound = snd_conv_david_sthg_santa_4;
cs.speaker = obj_npc_santa;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Hmm…";
cs.sound = snd_conv_david_sthg_gary_6;
cs.speaker = obj_player;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Kwanzaa is mentioned every year and I legit don’t know what it is.";
cs.sound = snd_conv_david_sthg_gary_7;
cs.speaker = obj_player;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Wait did that actually work?";
cs.sound = snd_conv_david_sthg_gary_8;
cs.speaker = obj_player;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Oh my secular deity, it did!";
cs.sound = snd_conv_david_sthg_santa_5;
cs.speaker = obj_npc_santa;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "The Dark Winter magic seal is broken! Go now, Gary, south, to the Abominable Lands, and rid us of this terrible beast! When you’re done, come back here, and we will vouch for you at the Olive Branch casino.";
cs.sound = snd_conv_david_sthg_david_4;
cs.speaker = obj_npc_david;
ds_list_add(c1.steps,cs);


return c1;