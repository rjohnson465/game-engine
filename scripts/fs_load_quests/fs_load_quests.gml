/// fs_load_quests(questsDataMap)
/// @param questsDataMap
/// creates quests from save game file

// destroy all quests, rebuild
with obj_quest_parent {
	instance_destroy(id,1);
}
ds_list_clear(global.player.quests);

var sd_quests = argument[0];
var cv = ds_map_find_first(sd_quests);
for (var j = 0; j < ds_map_size(sd_quests); j++) {
	
	var sd_quest = ds_map_find_value(sd_quests,cv);
	var questObjIndex = asset_get_index(cv);
	var questObj = instance_create_depth(x,y,1,questObjIndex);
	
	with questObj {
		currentQuestStepIndex = ds_map_find_value(sd_quest,"CurrentQuestStepIndex");
		currentQuestStep = ds_list_find_value(questSteps,currentQuestStepIndex);
		currentQuestStep.status = QuestStepStatus.InProgress; 
		isFinished = ds_map_find_value(sd_quest,"IsFinished");
		
		
		// update ALL quest step parameters based on save file data
		for (var i = 0; i < ds_list_size(questObj.questSteps); i++) {
			var qs = ds_list_find_value(questObj.questSteps,i);
			var paramsMap = ds_map_find_value(sd_quest,string(i)+"Parameters");
			if ds_map_size(paramsMap) > 0 {
				var ck = ds_map_find_first(paramsMap);
				for (var k = 0; k < ds_map_size(paramsMap); k++) {
					var val = ds_map_find_value(paramsMap,ck);
				
					ds_map_replace(qs.parameters,ck,val);
					
					ck = ds_map_find_next(paramsMap,ck);
				}
			}
			with qs {
				event_perform(ev_step, ev_step_begin);
			}
		}
		
		/*var paramsMap = ds_map_find_value(sd_quest,"Parameters");
		if ds_map_size(paramsMap) > 0 {
			var ck = ds_map_find_first(paramsMap);
			for (var k = 0; k < ds_map_size(paramsMap); k++) {
				var val = ds_map_find_value(paramsMap,ck);
				
				ds_map_replace(currentQuestStep.parameters,ck,val);
				
				ck = ds_map_find_next(paramsMap,ck);
			}
		}*/
	}
	
	if ds_map_find_value(sd_quest,"IsWatchedQuest") {
		global.questLog.watchedQuest = questObj;
	}
	
	if ds_map_find_value(sd_quest,"IsSelectedQuest") {
		global.questLog.selectedQuest = questObj;
	}
	
	ds_list_add(global.player.quests,questObj);
	
	cv = ds_map_find_next(sd_quests,cv);
}
