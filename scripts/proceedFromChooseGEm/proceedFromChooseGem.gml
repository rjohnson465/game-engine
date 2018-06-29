/// proceedFromChooseGem()
/// must be called by an instance of obj_fountain_gui_gems

audio_play_sound(snd_ui_click1,1,0);
if selectedItem == noone {
	alert("No gem selected",c_red); exit;
}

var namePriceGui = instance_nearest(x,y,obj_fountain_gui_nameprice);
namePriceGui.isAcceptingInput = false;
namePriceGui.alarm[0] = 1;
global.fountainGui.currentSubMenu = NAMEPRICE; 