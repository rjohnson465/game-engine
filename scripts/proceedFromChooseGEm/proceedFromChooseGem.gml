/// proceedFromChooseGem()
/// must be called by an instance of obj_fountain_gui_gems

var namePriceGui = instance_nearest(x,y,obj_fountain_gui_nameprice);
namePriceGui.isAcceptingInput = false;
namePriceGui.alarm[0] = 1;
global.fountainGui.currentSubMenu = NAMEPRICE; 