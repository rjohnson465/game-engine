if !ds_exists(quest.questSteps,ds_type_list) exit;

var pos = ds_list_find_index(quest.questSteps,id);
var nextStep = ds_list_find_value(quest.questSteps,pos+1);
if status == QuestStepStatus.Completed && nextStep != undefined && nextStep != noone && instance_exists(nextStep) {
	if nextStep.status == QuestStepStatus.Unstarted {
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
	}
}