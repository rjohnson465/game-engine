/// moveSkillSelector(direction)
/// @param direction "up" | "left" | "down" | "right"

var dir = argument[0];

if !isActive exit;

var closestSkill = selectedSkill; var closestDist = 10000;
with obj_skill_parent {
	
	var distToSelector = point_distance(x1,y1,other.x1,other.y1);
	
	if distToSelector < closestDist {
		var doSwitch = false;
		switch dir {
			case "up" : {
				if y1 < other.y1 doSwitch = true; break;
			}
			case "down" : {
				if y1 > other.y1 doSwitch = true; break;
			}
			case "left" : {
				if x1 < other.x1 doSwitch = true; break;
			}
			case "right" : {
				if x1 > other.x1 {
					doSwitch = true;
				} 
				
				// switch to quests
				if object_is_ancestor(other.selectedSkill.object_index,obj_spell_parent) {
					global.skillManager.isActive = false;
					global.questLog.isActive = true;
					if ds_list_find_value(global.player.quests,0) != undefined {
						global.questLog.selectedQuest = ds_list_find_value(global.player.quests,0);
					}
				}
				
				break;
			}
		}
		if doSwitch {
			closestDist = distToSelector;
			closestSkill = id;
		}
	}
}

x1 = closestSkill.x1;
y1 = closestSkill.y1;