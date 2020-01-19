global.ownerNpcName = "Santa";
var c1 = instance_create_depth(x,y,1,obj_conversation_parent);
c1.isUrgent = true;
c1.isRepeatable = false;
c1.name = "Santa Intro2";

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Oh my Lamplights, are you…?";
cs.sound = snd_conv_santa_intro2_gary_1;
cs.speaker = obj_player;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Am I…? Am I…? Spit it out, Gary, I’m on a clock here. Christmas is in less than 24 hours. Always!";
cs.sound = snd_conv_santa_intro2_santa_1;
cs.speaker = obj_npc_santa;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "You know my name?";
cs.sound = snd_conv_santa_intro2_gary_2;
cs.speaker = obj_player;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "What kind of omnipotent, quasi-religious, reindeer obsessed, gambling addicted gift-flinger would I be if I didn’t?";
cs.sound = snd_conv_santa_intro2_santa_2;
cs.speaker = obj_npc_santa;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Wait, did you just say gambling addicted?";
cs.sound = snd_conv_santa_intro2_gary_3;
cs.speaker = obj_player;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Don’t tell Mrs. Claus, okay? She thinks I’m just having an affair, I couldn’t bear to tell her the truth.";
cs.sound = snd_conv_santa_intro2_santa_3;
cs.speaker = obj_npc_santa;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Ugh, marriage. Anyway, David, from Hannukah Town, sent me here to see if you’d help unseal the way to the Abominable Lands. He said you knew half the spell, and he knows the other half.";
cs.sound = snd_conv_santa_intro2_gary_4;
cs.speaker = obj_player;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Ew, David, that saucy boy. He refuses to lend me gambling money. But, I suppose all hatchets should be buried. In David’s face, preferably, but not today.";
cs.sound = snd_conv_santa_intro2_santa_4;
cs.speaker = obj_npc_santa;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Look, I’ll help, but only if David shows me he’s serious he wants to mend fences. He’s got a special star that he named after himself, that narcissist. Probably keeps it somewhere near Hanukkah Town, in the Clayfields.";
cs.sound = snd_conv_santa_intro2_santa_5;
cs.speaker = obj_npc_santa;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "If he’s willing to give me that, I’ll give him my precious and much less narcissistic Christmas Star. Unfortunately, I dropped it somewhere North of here, in the Krampus Tundra. When you’ve got both items, come talk to either of us, and we’ll see if that’s enough to put our past behind us.";
cs.sound = snd_conv_santa_intro2_santa_6;
cs.speaker = obj_npc_santa;
cs.func = scr_quest_sth_step3;
cs.funcParam1 = obj_npc_santa;
ds_list_add(c1.steps,cs);

return c1;