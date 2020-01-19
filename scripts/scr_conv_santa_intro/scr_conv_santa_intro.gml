global.ownerNpcName = "Santa";
var c1 = instance_create_depth(x,y,1,obj_conversation_parent);
c1.isUrgent = true;
c1.isRepeatable = false;
c1.name = "Santa Intro";

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Oh my Lamplights, are you…?";
cs.sound = snd_conv_santa_intro_gary_1;
cs.speaker = obj_player;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Am I…? Am I…? Spit it out, Gary, I’m on a clock here. Christmas is in less than 24 hours. Always!";
cs.sound = snd_conv_santa_intro_santa_1;
cs.speaker = obj_npc_santa;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "You know my name?";
cs.sound = snd_conv_santa_intro_gary_2;
cs.speaker = obj_player;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "What kind of omnipotent, quasi-religious, reindeer obsessed, gambling addicted gift-flinger would I be if I didn’t?";
cs.sound = snd_conv_santa_intro_santa_2;
cs.speaker = obj_npc_santa;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Wait, did you just say gambling addicted?";
cs.sound = snd_conv_santa_intro_gary_3;
cs.speaker = obj_player;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Don’t tell Mrs. Claus, okay? She thinks I’m just having an affair, I couldn’t bear to tell her the truth.";
cs.sound = snd_conv_santa_intro_santa_3;
cs.speaker = obj_npc_santa;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Ugh, marriage. Fine, but does this mean you’re a member in good standing with the Olive Branch casino?";
cs.sound = snd_conv_santa_intro_gary_4;
cs.speaker = obj_player;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "I’d hope so! I practically keep those boys in business!";
cs.sound = snd_conv_santa_intro_santa_4;
cs.speaker = obj_npc_santa;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Excellent, can you vouch for me so I can get in?";
cs.sound = snd_conv_santa_intro_gary_5;
cs.speaker = obj_player;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Why would I vouch for you, I just met you!";
cs.sound = snd_conv_santa_intro_santa_5;
cs.speaker = obj_npc_santa;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "I thought you said you were omnipotent.";
cs.sound = snd_conv_santa_intro_gary_6;
cs.speaker = obj_player;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "You saucy boy, how badly do you want coal this year?";
cs.sound = snd_conv_santa_intro_santa_6;
cs.speaker = obj_npc_santa;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Look, what do I have to do to get you to vouch for me? Just give me a fetch quest or something.";
cs.sound = snd_conv_santa_intro_gary_7;
cs.speaker = obj_player;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Nah, what if you murder something for me instead?";
cs.sound = snd_conv_santa_intro_santa_7;
cs.speaker = obj_npc_santa;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Yeah, sure, whatever.";
cs.sound = snd_conv_santa_intro_gary_8;
cs.speaker = obj_player;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Okay, south of Winter Wonderground, there’s a terrible beast -- The Abominable Snowman. Kill it, and I’ll vouch for you.";
cs.sound = snd_conv_santa_intro_santa_8;
cs.speaker = obj_npc_santa;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Cool, I’ll be back in like twenty minutes --";
cs.sound = snd_conv_santa_intro_gary_9;
cs.speaker = obj_player;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Wait hold up -- getting into his domain, The Abominable Lands, is tricky. It’s sealed by his Dark Winter magic. The only way to break that seal is a spell -- a spell I only know half of.";
cs.sound = snd_conv_santa_intro_santa_9;
cs.speaker = obj_npc_santa;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Jesus, this is convoluted.";
cs.sound = snd_conv_santa_intro_gary_10;
cs.speaker = obj_player;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "The other half is known by the leader of Hanukkah Town, David. We’ll need to work together to get the spell to work";
cs.sound = snd_conv_santa_intro_santa_10;
cs.speaker = obj_npc_santa;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Okay, FINE, I’ll go talk to David.";
cs.sound = snd_conv_santa_intro_gary_11;
cs.speaker = obj_player;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Cool, also, we hate each other, so we might need to deal with that first, head’s up.";
cs.sound = snd_conv_santa_intro_santa_11;
cs.speaker = obj_npc_santa;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Wow, so now I’ve gotta solve your personal problems, and kill a monster.";
cs.sound = snd_conv_santa_intro_gary_12;
cs.speaker = obj_player;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Yup, now go talk to David, and don’t mess up! Merry Christmas!";
cs.sound = snd_conv_santa_intro_santa_12;
cs.speaker = obj_npc_santa;
cs.func = scr_quest_sth_step2;
cs.funcParam1 = obj_npc_santa;
ds_list_add(c1.steps,cs);

return c1;