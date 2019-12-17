
global.ownerNpcName = "Robort";
var c1 = instance_create_depth(x,y,1,obj_conversation_parent);
c1.isRepeatable = false;
c1.name = "Lamplight Factory Investigation (Complete)";
c1.isUrgent = true;
c1.narrativeState = NarrativeState.WinterWonderground;

var c = instance_create_depth(x,y,1,obj_conversation_step_parent);
c.text = "How’d it go in there? I heard lots of screaming.";
c.sound = snd_conv_rob_llfe_rob_1;
c.speaker = obj_npc_rob;
ds_list_add(c1.steps,c);

var c = instance_create_depth(x,y,1,obj_conversation_step_parent);
c.text = "I killed a slug lobster thing that ate lamplights.";
c.sound = snd_conv_rob_llfe_gary_1;
c.speaker = obj_player;
ds_list_add(c1.steps,c);

var c = instance_create_depth(x,y,1,obj_conversation_step_parent);
c.text = "Oh Gods, the lamplights! I mean… are you okay?";
c.sound = snd_conv_rob_llfe_rob_2;
c.speaker = obj_npc_rob;
ds_list_add(c1.steps,c);

var c = instance_create_depth(x,y,1,obj_conversation_step_parent);
c.text = "Aside from being poisoned and burned relentlessly, yes. An unfairy with questionable facial hair choices named Tony dropped this red and green wire, do you know anything about this?";
c.sound = snd_conv_rob_llfe_gary_2;
c.speaker = obj_player;
ds_list_add(c1.steps,c);

var c = instance_create_depth(x,y,1,obj_conversation_step_parent);
c.text = "Ah yes, a moustached unfairy just used a wire like this to go to Floor 0.";
c.sound = snd_conv_rob_llfe_rob_3;
c.speaker = obj_npc_rob;
c.func = scr_rob_take_strangewire;
ds_list_add(c1.steps,c);

var c = instance_create_depth(x,y,1,obj_conversation_step_parent);
c.text = "You let him? Robort, why?";
c.sound = snd_conv_rob_llfe_gary_3;
c.speaker = obj_player;
ds_list_add(c1.steps,c);

var c = instance_create_depth(x,y,1,obj_conversation_step_parent);
c.text = "Jeez, he had a gun, I was scared. Please don’t yell at me, I will cry.";
c.sound = snd_conv_rob_llfe_rob_4;
c.speaker = obj_npc_rob;
ds_list_add(c1.steps,c);

var c = instance_create_depth(x,y,1,obj_conversation_step_parent);
c.text = "I need to follow Tony and see how deep this conspiracy goes. Can you take me to Floor 0?";
c.sound = snd_conv_rob_llfe_gary_4;
c.speaker = obj_player;
ds_list_add(c1.steps,c);

var c = instance_create_depth(x,y,1,obj_conversation_step_parent);
c.text = "As long as you’ve got the wire, yes. Honestly, I’m mostly just hear to look pretty.";
c.sound = snd_conv_rob_llfe_rob_45;
c.speaker = obj_npc_rob; 
ds_list_add(c1.steps,c);

var c = instance_create_depth(x,y,1,obj_conversation_step_parent);
c.text = "Let me know when you’re ready. I’ll take you to Floor 0. I don’t know what’s down there, but good luck.";
c.sound = snd_conv_rob_llfe_rob_5;
c.speaker = obj_npc_rob;
c.func = completeQuest;
c.funcParam1 = instance_nearest(x,y,obj_quest_llf);
ds_list_add(c1.steps,c);

return c1;