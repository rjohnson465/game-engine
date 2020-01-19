performCutscene = true;
setTonysPath = false;
var questNum = instance_number(obj_quest_savingtheholidays);
if questNum > 0 {
	instance_destroy(id, 1);
	performCutscene = false;
}

