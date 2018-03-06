//depth = 250;
// floorNum is the floor level tiles this object will draw
// it will shade these tiles darker if the player is on a floor higher than this
floorNum = global.floorNum; 
surface_canvas_1 = -1;
surface_canvas_2 = -1;
layersToShade = ds_list_create();
uPOSITION = shader_get_uniform(sh_saturation, "Position"); // control shader

//blur = 0.4
//color = make_colour_rgb(0.2*255, 0.2*255, 0.2 * 255); // The darker the color, the darker the shadow.
