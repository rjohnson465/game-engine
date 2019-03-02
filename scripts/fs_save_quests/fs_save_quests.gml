/// fs_save_quests
/// returns a map of all quests
var sd_quests = ds_map_create();
with obj_quest_parent {
	var sd_quest = ds_map_create();
	
	ds_map_replace(sd_quest,"CurrentQuestStepIndex",currentQuestStepIndex);
	
	// save the state of any and all parameters for ALL quest steps
	for (var i = 0; i < ds_list_size(questSteps); i++) {
		var qs = ds_list_find_value(questSteps,i);
		with qs {
			var cv = ds_map_find_first(parameters);
			var paramsMap = ds_map_create();
			for (var j = 0; j < ds_map_size(parameters); j++) {
				var val = ds_map_find_value(parameters,cv);
				ds_map_add(paramsMap,cv,val);
			
				cv = ds_map_find_next(parameters,cv);
			}
			ds_map_add_map(sd_quest,string(i)+"Parameters",paramsMap);
		}
	}
	
	/*
	with currentQuestStep {
		var cv = ds_map_find_first(parameters);
		var paramsMap = ds_map_create();
		for (var i = 0; i < ds_map_size(parameters); i++) {
			var val = ds_map_find_value(parameters,cv);
			ds_map_add(paramsMap,cv,val);
			
			cv = ds_map_find_next(parameters,cv);
		}
		ds_map_add_map(sd_quest,"Parameters",paramsMap);
	}*/
	
	if global.questLog.watchedQuest == id {
		ds_map_replace(sd_quest,"IsWatchedQuest",1);
	} else ds_map_replace(sd_quest,"IsWatchedQuest",0);
	
	if global.questLog.selectedQuest == id {
		ds_map_replace(sd_quest,"IsSelectedQuest",1);
	} else ds_map_replace(sd_quest,"IsSelectedQuest",0);
	
	ds_map_replace(sd_quest,"IsFinished",isFinished);
	
	var key = object_get_name(object_index);

	ds_map_add_map(sd_quests,key,sd_quest);
}

// also remember how many quests at reward step the player has pending
ds_map_replace(sd_quests, "questsAtRewardStepCount", global.player.questsAtRewardStepCount);

return sd_quests;