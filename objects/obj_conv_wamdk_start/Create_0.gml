event_inherited();
name = "Where Are My Damn Keys";
ownerNpcName = "The Elder, Barry";
isUrgent = true;
narrativeState = NarrativeState.Start;

var s = instance_create_depth(x,y,1,obj_conversation_step_parent);
s.text = "Oh hi Gary! What a day, let me tell ya. My coffee machine broke this morning, and now there’s this whole genocide thing, what’s a fairy gotta do to catch a break around here, huh?";
s.sound = snd_conv_start_barry_1;
ds_list_add(steps, s);

s = instance_create_depth(x,y,1,obj_conversation_step_parent);
s.text = "Oh my god, Barry, that’s horrible. What happened?";
s.sound = snd_conv_start_gary_1;
ds_list_add(steps, s);

s = instance_create_depth(x,y,1,obj_conversation_step_parent);
s.text = "Not sure, I think the filter’s torn, and now there are grounds in my coffee.";
s.sound = snd_conv_start_barry_2;
ds_list_add(steps, s);

s = instance_create_depth(x,y,1,obj_conversation_step_parent);
s.text = "No, the genocide thing!";
s.sound = snd_conv_start_gary_2;
ds_list_add(steps, s);

s = instance_create_depth(x,y,1,obj_conversation_step_parent);
s.text = "Oh yeah, the unfairies invaded us. Murdered our people. Stole our sacred lamplights. And I think I saw one of them litter.";
s.sound = snd_conv_start_barry_3;
ds_list_add(steps, s);

s = instance_create_depth(x,y,1,obj_conversation_step_parent);
s.text = "Unfairies? I thought they lived across the sea, and we negotiated peace with them hundreds of years ago.";
s.sound = snd_conv_start_gary_3;
ds_list_add(steps, s);

s = instance_create_depth(x,y,1,obj_conversation_step_parent);
s.text = "Never trust an unfairy, Gary. Be wary. They’re scary.";
s.sound = snd_conv_start_barry_4;
ds_list_add(steps, s);

s = instance_create_depth(x,y,1,obj_conversation_step_parent);
s.text = "Why are they called unfairies?";
s.sound = snd_conv_start_gary_4;
ds_list_add(steps, s);

s = instance_create_depth(x,y,1,obj_conversation_step_parent);
s.text = "It’d be unfair to call them fairies.";
s.sound = snd_conv_start_barry_5;
ds_list_add(steps, s);

s = instance_create_depth(x,y,1,obj_conversation_step_parent);
s.text = "...What?";
s.sound = snd_conv_start_gary_5;
ds_list_add(steps, s);

s = instance_create_depth(x,y,1,obj_conversation_step_parent);
s.text = "Listen Gary, there’s no time! All our warriors were murdered, so it’s my duty as elder to task you with cleaning up this mess. The blessed light of our lamps is gone, I must guard this last one here.";
s.sound = snd_conv_start_barry_6;
ds_list_add(steps, s);

s = instance_create_depth(x,y,1,obj_conversation_step_parent);
s.text = "Fine, where do I go?";
s.sound = snd_conv_start_gary_6;
ds_list_add(steps, s);

s = instance_create_depth(x,y,1,obj_conversation_step_parent);
s.text = "After attacking, most unfairies went south. I fear they plan to assault the lamplight factory. You’ll need my keys to get in.";
s.sound = snd_conv_start_barry_7;
ds_list_add(steps, s);

s = instance_create_depth(x,y,1,obj_conversation_step_parent);
s.text = "Ok... where are your keys?";
s.sound = snd_conv_start_gary_7;
ds_list_add(steps, s);

s = instance_create_depth(x,y,1,obj_conversation_step_parent);
s.text = "Oh, I don’t know, I must have dropped them when I fled here. Maybe one of the unfairies picked them up. Find them, avenge our dead, reclaim our sacred lamplights, and fix my coffee maker, if you find the time. Here, take this. You'll need it.";
s.sound = snd_conv_start_barry_8;
s.func = questStart;
s.funcParam1 = obj_quest_wamdk;
ds_list_add(steps, s);

s = instance_create_depth(x,y,1,obj_conversation_step_parent);
s.text = "";
s.sound = noone;
s.func = giveItemRewardChoice;
var items = ds_list_create();
ds_list_add(items, instance_create_depth(x, y, 1, obj_hand_item_longsword));
ds_list_add(items, instance_create_depth(x, y, 1, obj_hand_item_club));
ds_list_add(items, instance_create_depth(x, y, 1, obj_hand_item_spear));
ds_list_add(items, instance_create_depth(x, y, 1, obj_hand_item_dagger));
s.funcParam1 = items;
ds_list_add(steps, s);