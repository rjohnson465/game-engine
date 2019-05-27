// quest specific shit

// if Great-Lodge entered without starting WAMDK, WAMDK automatically started

if variable_instance_exists(id, "doorKey") && doorKey == "wamdkDoor" && alarm[0] > 0 {
	if instance_number(obj_quest_wamdk) == 0 {
		questStart(obj_quest_wamdk);
	}
}