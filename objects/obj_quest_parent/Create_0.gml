questGiver = noone;
name = "Quest";
description = "Quest description";
isFinished = false;
isRewardClaimed = false;
questSteps = ds_list_create();
currentQuestStep = noone;
currentQuestStepIndex = noone;

isRepeatable = false;

xpReward = 0;
rewardItems = ds_list_create();
persistent = true;
