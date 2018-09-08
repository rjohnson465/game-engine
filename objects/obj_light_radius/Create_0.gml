owner = global.owner;

if owner.object_index == obj_player || owner == global.player {
	persistent = true;
	owner.playerLightRadius = id;
}


makeLightOnCreate = global.makeLightOnCreate;
color = owner.lightRadiusColor;
colorAlpha = owner.lightRadiusAlpha;
spr = owner.lightRadiusSprite;
scale = owner.lightRadiusScale;
if makeLightOnCreate && ds_exists(global._lights,ds_type_list) {
	light_create(spr, scale, color, colorAlpha, 0, true);
}
rot_inc = 20;
index = 0;