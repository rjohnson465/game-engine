event_inherited();
name = "Investigate the Lamplight Factory";
ownerNpcName = "Robort";
isUrgent = true;
narrativeState = NarrativeState.LamplightFactory;

var s = instance_create_depth(x,y,1,obj_conversation_step_parent);
s.text = "Ah! Another unfairy! Leave my circuits alone! Robort has done nothing wrong.";
s.sound = snd_conv_rob_intro_rob_1;
s.speaker = obj_npc_rob;
ds_list_add(steps, s);

s = instance_create_depth(x,y,1,obj_conversation_step_parent);
s.text = "Hey relax man, look -- I’m a fairy. I’m not even red.";
s.sound = snd_conv_rob_intro_gary_1;
s.speaker = obj_player;
ds_list_add(steps, s);

s = instance_create_depth(x,y,1,obj_conversation_step_parent);
s.text = "Oh oops, personally, Robort doesn’t see color...";
s.sound = snd_conv_rob_intro_rob_2;
s.speaker = obj_npc_rob;
ds_list_add(steps, s);

s = instance_create_depth(x,y,1,obj_conversation_step_parent);
s.text = "Ok chill, don’t make this a race thing.";
s.sound = snd_conv_rob_intro_gary_2;
s.speaker = obj_player;
ds_list_add(steps, s);

s = instance_create_depth(x,y,1,obj_conversation_step_parent);
s.text = "No, Robort is not programmed to see color.";
s.sound = snd_conv_rob_intro_rob_3;
s.speaker = obj_npc_rob;
ds_list_add(steps, s);

s = instance_create_depth(x,y,1,obj_conversation_step_parent);
s.text = "Er...You said you saw unfairies?";
s.sound = snd_conv_rob_intro_gary_3;
s.speaker = obj_player;
ds_list_add(steps, s);

s = instance_create_depth(x,y,1,obj_conversation_step_parent);
s.text = "All over the factory, they’re heading up, stealing and smashing things.";
s.sound = snd_conv_rob_intro_rob_4;
s.speaker = obj_npc_rob;
ds_list_add(steps, s);

s = instance_create_depth(x,y,1,obj_conversation_step_parent);
s.text = "I need to search the factory and find the unfairy leader.  Can you take me there?";
s.sound = snd_conv_rob_intro_gary_4;
s.speaker = obj_player;
ds_list_add(steps, s);

s = instance_create_depth(x,y,1,obj_conversation_step_parent);
s.text = "Yes. No. Uh… cannot compute.";
s.sound = snd_conv_rob_intro_rob_5
s.speaker = obj_npc_rob;
ds_list_add(steps, s);

s = instance_create_depth(x,y,1,obj_conversation_step_parent);
s.text = "...What?";
s.sound = snd_conv_rob_intro_gary_5;
s.speaker = obj_player;
ds_list_add(steps, s);

s = instance_create_depth(x,y,1,obj_conversation_step_parent);
s.text = "Robort can take us to floors 1 through 3. Unfairies broke the mechanism to get to Floor 4.";
s.sound = snd_conv_rob_intro_rob_6;
s.speaker = obj_npc_rob;
ds_list_add(steps, s);

s = instance_create_depth(x,y,1,obj_conversation_step_parent);
s.text = "I swear to God, if this is a fetch quest...";
s.sound = snd_conv_rob_intro_gary_6;
s.speaker = obj_player;
ds_list_add(steps, s);

s = instance_create_depth(x,y,1,obj_conversation_step_parent);
s.text = "Fetch Robort wires. Three of them… red, white, and blue. Then Robort takes you to Floor 4.";
s.sound = snd_conv_rob_intro_rob_7;
s.speaker = obj_npc_rob;
s.func = questStart;
s.funcParam1 = obj_quest_llf;
ds_list_add(steps, s);

