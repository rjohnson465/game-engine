global.ownerNpcName = "David";
var c1 = instance_create_depth(x,y,1,obj_conversation_parent);
c1.isUrgent = true;
c1.isRepeatable = false;
c1.name = "David Intro2";

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Shalom! I am David, leader of Hanukkah Village.";
cs.sound = snd_conv_david_intro2_david_1;
cs.speaker = obj_npc_david;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Oh, uh, hi. I am Gary, drinker of whiskey. How much are we gonna push the religious thing? I’m getting nervous.";
cs.sound = snd_conv_david_intro2_gary_1;
cs.speaker = obj_player;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Oh, don’t worry we’ll keep it all pretty cultural. I’d wager all my latkes we’ll steer clear of a lawsuit.";
cs.sound = snd_conv_david_intro2_david_2;
cs.speaker = obj_npc_david;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Oy vey. Anyway, Santa sent me here to see if you’d help unseal the way to the Abominable Lands. He said you each know half the spell.";
cs.sound = snd_conv_david_intro2_gary_2;
cs.speaker = obj_player;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Ugh, Santa, that conniving little manyak. So cheery, all the time, always flirting with his reindeer. But, I suppose we could make it water under the bridge, if we can’t just put him under the bridge.";
cs.sound = snd_conv_david_intro2_david_3;
cs.speaker = obj_npc_david;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Yikes, what did he do to you?";
cs.sound = snd_conv_david_intro2_gary_3;
cs.speaker = obj_player;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Look, I’ll help, but only if Santa shows me he’s serious he wants to mend fences. He’s got a special Christmas Star he’s obsessed with. Probably keeps it somewhere near Christmas Town, in the Krampus Tundra.";
cs.sound = snd_conv_david_intro2_david_4;
cs.speaker = obj_npc_david;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "If he’s willing to give me that, I’ll give him my beloved Star of Me.";
cs.sound = snd_conv_david_intro2_david_5;
cs.speaker = obj_npc_david;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "What?";
cs.sound = snd_conv_david_intro2_gary_4;
cs.speaker = obj_player;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Star of David.";
cs.sound = snd_conv_david_intro2_david_6;
cs.speaker = obj_npc_david;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Right, yup, not gonna touch that one.";
cs.sound = snd_conv_david_intro2_gary_5;
cs.speaker = obj_player;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "I dropped it somewhere South of here, in the Clayfields. When you’ve got both items, come talk to either of us, and we’ll see if that’s enough to make us Kosher.";
cs.sound = snd_conv_david_intro2_david_7;
cs.speaker = obj_npc_david;
cs.func = scr_quest_sth_step3;
cs.funcParam1 = obj_npc_david;
ds_list_add(c1.steps,cs);

return c1;