global.ownerNpcName = "David";
var c1 = instance_create_depth(x,y,1,obj_conversation_parent);
c1.isUrgent = true;
c1.isRepeatable = false;
c1.name = "David Intro";

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Shalom! I am David, leader of Hanukkah Village.";
cs.sound = snd_conv_david_intro_david_1;
cs.speaker = obj_npc_david;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Oh, uh, hi. I am Gary, drinker of whiskey. How much are we gonna push the religious thing? I’m getting nervous.";
cs.sound = snd_conv_david_intro_gary_1;
cs.speaker = obj_player;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Oh, don’t worry we’ll keep it all pretty cultural. I’d wager all my latkes we’ll steer clear of a lawsuit.";
cs.sound = snd_conv_david_intro_david_2;
cs.speaker = obj_npc_david;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Yeah, we’re off to a great start. Wait, did you say wager? Do you gamble? Maybe at the Olive Branch casino?";
cs.sound = snd_conv_david_intro_gary_2;
cs.speaker = obj_player;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Oh, indeed, dear Gary, indeed. I love gambling more than my mother’s briskets!";
cs.sound = snd_conv_david_intro_david_3;
cs.speaker = obj_npc_david;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Oy vey. Ok, what’ll it take to get you to vouch for me so I can get into the casino?";
cs.sound = snd_conv_david_intro_gary_3;
cs.speaker = obj_player;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Simple: I want you to save Hanukkah.";
cs.sound = snd_conv_david_intro_david_4;
cs.speaker = obj_npc_david;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "I straight up don’t think I’m qualified.";
cs.sound = snd_conv_david_intro_gary_4;
cs.speaker = obj_player;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "It’s the most important time of the year, and it happens every day here in Winter Wonderground. Eight times a day. I am constantly buying gifts for my little mensch, Hans";
cs.sound = snd_conv_david_intro_david_5;
cs.speaker = obj_npc_david;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Oof that sounds stressful. Wait, Hans?";
cs.sound = snd_conv_david_intro_gary_5;
cs.speaker = obj_player;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Yeah, I married a German girl.";
cs.sound = snd_conv_david_intro_david_6;
cs.speaker = obj_npc_david;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "…… Cool. What’s the fastest way out of this conversation?";
cs.sound = snd_conv_david_intro_gary_6;
cs.speaker = obj_player;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Here: The Abominable Snowman and his minions are wreaking havoc on us as we go out shopping for Hanukkah. I need you to kill him. You do this, I vouch for you.";
cs.sound = snd_conv_david_intro_david_7;
cs.speaker = obj_npc_david;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "To get to him, you need to get into the Abominable Lands, which are sealed with Dark Winter magic, which can only be broken by a spell, which I only know half of.";
cs.sound = snd_conv_david_intro_david_8;
cs.speaker = obj_npc_david;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Jesus, this is convoluted.";
cs.sound = snd_conv_david_intro_gary_7;
cs.speaker = obj_player;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Did you say “Jesus”?";
cs.sound = snd_conv_david_intro_david_9;
cs.speaker = obj_npc_david;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Um… who knows the other half of the spell?";
cs.sound = snd_conv_david_intro_gary_8;
cs.speaker = obj_player;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "That sad sack excuse for a fairy, Santa, who lives in Christmas Town, on the eastern side of Winter Wonderground. He and I will need to work together to get the spell to work.";
cs.sound = snd_conv_david_intro_david_10;
cs.speaker = obj_npc_david;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Alright, great, I’ll go talk to him.";
cs.sound = snd_conv_david_intro_gary_9;
cs.speaker = obj_player;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Wonderful. Keep in mind, he’s a conniving little manyak so watch yourself.";
cs.sound = snd_conv_david_intro_david_11;
cs.speaker = obj_npc_david;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Yep, I’m hoping no one translates that. Or speaks Hebrew.";
cs.sound = snd_conv_david_intro_gary_10;
cs.speaker = obj_player;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Very good, Gary. Happy Hannukkah!";
cs.sound = snd_conv_david_intro_david_12;
cs.speaker = obj_npc_david;
cs.func = scr_quest_sth_step2;
cs.funcParam1 = obj_npc_david;
ds_list_add(c1.steps,cs);

return c1;