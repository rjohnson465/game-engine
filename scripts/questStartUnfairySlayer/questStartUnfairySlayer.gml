/// questStartUnfairySlayer

var quest = instance_create_depth(x,y,1,obj_quest_unfairyslayer);
ds_list_add(global.player.quests,quest);
alert("Unfairy Slayer added to Quest Log",c_yellow);