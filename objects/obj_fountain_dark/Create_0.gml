lightRadius = 256;
lightRadiusAlpha = .35;
lightRadiusScale = .75;
lightRadiusColor = c_red;
lightRadiusSprite = spr_light_point;
isShowingLightRadius = true;
event_inherited();

origLayer = layer;
fountainRunningSoundEmitter = audio_emitter_create();
audio_emitter_position(fountainRunningSoundEmitter,x,y,layer_get_depth(origLayer));
audio_emitter_falloff(fountainRunningSoundEmitter,50,800,1);
audio_emitter_gain(fountainRunningSoundEmitter,0);
fountainRunningSound = snd_fountain_running;
fountainRunningSoundIndex = noone;
audio_play_sound_on(fountainRunningSoundEmitter,snd_fountain_running,1,0);


layerName = layer_get_name(layer);

inUse = false;

num = random_range(10,25);


layerName = layer_get_name(layer);

inUse = false;


// shader for ripple
uni_time = shader_get_uniform(shd_radial_blur,"time");
var_time_var = 0;

uni_mouse_pos = shader_get_uniform(shd_radial_blur,"mouse_pos");
var_mouse_pos_x = x;
var_mouse_pos_y = y;

uni_resolution = shader_get_uniform(shd_radial_blur,"resolution");
var_resolution_x = view_get_wport(0);
var_resolution_y = view_get_hport(0);

uni_radial_blur_offset = shader_get_uniform(shd_radial_blur,"radial_blur_offset");
var_radial_blur_offset = 0.05;

uni_radial_brightness = shader_get_uniform(shd_radial_blur,"radial_brightness");
var_radial_brightness = 1;


teleportX = noone;
teleportY = noone;


