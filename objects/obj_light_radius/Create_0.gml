owner = global.owner;
color = owner.lightRadiusColor;
colorAlpha = owner.lightRadiusAlpha;
spr = owner.lightRadiusSprite;
scale = owner.lightRadiusScale;
light_create(spr, scale, color, colorAlpha, 0, true);
rot_inc = 20;
index = 0;