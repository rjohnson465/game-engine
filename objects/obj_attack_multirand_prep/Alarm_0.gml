global.attackData = attackData;
global.owner = owner;

instance_create_depth(x,y,depth,obj_attack_multirand);

instance_destroy(id, 1);