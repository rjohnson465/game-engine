if (!surface_exists(lightSurf)) {
    lightSurf = surface_create(room_width, room_height);
}

// starting shader arrays
var shdPosX;
var shdPosY;
var shdRad;

var numLight = instance_number(obj_light);
// in case there are no lights, make sure the shader arrays aren't empty
if (numLight == 0) {
    shdPosX[0] = 0.0;
    shdPosY[0] = 0.0;
    shdRad[0] = 0.0;
}

surface_set_target(lightSurf);
draw_clear_alpha(0,0);
gpu_set_blendmode(bm_add);

// for each light
for (var i=0;i<3;i++) {
    if (i < numLight) {
        var lightInst = instance_find(obj_light, i);
        shdPosX[i] = lightInst.x;
        shdPosY[i] = lightInst.y;
        shdRad[i] = rad;
        vertex_begin(VBuffer, VertexFormat);

        for(var j=0; j<instance_number(obj_wall); j++)
        {
            var inst = instance_find(obj_wall, j);
            if (!inst.disableLighting) {
                //ProjectShadow(VBuffer, colourArray[i], x-320, y-180, inst.line[0,0]+inst.x, -inst.line[0,1]+inst.y, inst.line[1,0]+inst.x, -inst.line[1,1]+inst.y, lightInst.x, lightInst.y);
                }
            }
            vertex_end(VBuffer);
            vertex_submit(VBuffer, pr_trianglelist, -1);
        }
    else {
        // if not enough lights, just draw a block of the shadow
        shdPosX[i] = -100.0;
        shdPosY[i] = 0.0;
        shdRad[i] = 0.0;
        draw_rectangle_color(0,0,640,360,colourArray[i],colourArray[i],colourArray[i],colourArray[i],false);
    }
}

surface_reset_target();
gpu_set_blendmode(bm_normal);

shader_set(shd_light);
shader_set_uniform_f_array(LightPosX, shdPosX);
shader_set_uniform_f_array(LightPosY, shdPosY);
shader_set_uniform_f_array(LightRad, shdRad);
shader_set_uniform_f_array(LightColR, shdColourR);
shader_set_uniform_f_array(LightColG, shdColourG);
shader_set_uniform_f_array(LightColB, shdColourB);

draw_surface(lightSurf,x-320,y-180);

shader_reset();