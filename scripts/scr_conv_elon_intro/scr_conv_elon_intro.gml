global.ownerNpcName = "Elon";
var c1 = instance_create_depth(x,y,1,obj_conversation_parent);
c1.isUrgent = true;
c1.isRepeatable = false;
c1.name = "Elon Intro";

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Hello friend! I’m Elon. Happy holidays to you!";
cs.sound = snd_conv_elon_intro_elon_1;
cs.speaker = obj_npc_elon;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Oh hi Elon. I’m Gary. Quick question, where the heck am I?";
cs.sound = snd_conv_elon_intro_gary_1;
cs.speaker = obj_player;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Oh, friend, you’ve found the most fantastic place in the world. This is Winter Wonderground, the underground home of always Christmas! And Hanukkah! And all the holidays! Please don’t start a hashtag";
cs.sound = snd_conv_elon_intro_elon_2;
cs.speaker = obj_npc_elon;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Uh… right. Fun as that sounds, I need to get into the casino, north of here. Can you vouch for me?";
cs.sound = snd_conv_elon_intro_gary_2;
cs.speaker = obj_player;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Me? By St. Nick’s beard, no sir! I was banned for counting cards years ago. Try one of the villages, they’re full of gamblers. Christmas Town is southeast of here, while Hannukah Village is to the southwest.";
cs.sound = snd_conv_elon_intro_elon_3;
cs.speaker = obj_npc_elon;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Thanks, I’ll be on my way.";
cs.sound = snd_conv_elon_intro_gary_3;
cs.speaker = obj_player;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Good luck, the wilderness is full of danger. You could always just stay and celebrate the holidays with me and my muskox friends here!";
cs.sound = snd_conv_elon_intro_elon_4;
cs.speaker = obj_npc_elon;
ds_list_add(c1.steps,cs);

return c1;