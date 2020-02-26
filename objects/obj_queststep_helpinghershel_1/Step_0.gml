if status != QuestStepStatus.InProgress exit;

if instance_number(obj_player_death) > 0 && description != "Hershel ripped out his heart to avoid possession. Speak with Ari." {
	description = "Hershel ripped out his heart to avoid possession. Speak with Ari.";
}