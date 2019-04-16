/// maybeMakeHealthOrb()
/// must be called by combatant

randomize();
var rand = random_range(0,1);
if rand < chanceToDropHealthOrb {
	global.fromEnemyIndex = id;
	instance_create_depth(x,y,1,obj_health_orb);
}