if !ds_exists(quest.questSteps,ds_type_list) exit;

var pos = ds_list_find_index(quest.questSteps,id);
var nextStep = ds_list_find_value(quest.questSteps,pos+1);
if status == QuestStepStatus.Completed && nextStep != undefined && nextStep != noone && instance_exists(nextStep) {
	
	// by default, alert player this quest step is completed 
	if nextStep.status == QuestStepStatus.Unstarted {
		if !quest.isFinished {
			alertQuestUpdate(quest);
		}
		nextStep.status = QuestStepStatus.InProgress;
		quest.currentQuestStep = nextStep;
		quest.currentQuestStepIndex = pos+1;
		if nextStep.isRewardStep {
			audio_play_sound(snd_ui_quest_complete_alert,1,0);
			// increment how many quests the player has at reward step
			global.player.questsAtRewardStepCount++;
			
			with obj_npc_parent {
				refreshNpcConversations();
			}
		}
		
		// maybe run activation script
		if nextStep.activationScript != noone && script_exists(nextStep.activationScript) {
			if nextStep.activationScriptParams != noone {
				with nextStep {
					script_execute(nextStep.activationScript, nextStep.activationScriptParams);
				}
			} else {
				with nextStep {
					script_execute(nextStep.activationScript);
				}
			}
		}
		
		// maybe refresh npc convos too, if we're not already in a convo
		with obj_npc_parent {
			if !isInConversation {
				refreshNpcConversations();
			}
		}
	}
}