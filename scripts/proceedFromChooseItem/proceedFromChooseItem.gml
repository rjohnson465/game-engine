/// proceedFromChooseItem()
/// must be called by instance of obj_fountain_gui_socketeditems
var gemGui = instance_nearest(x,y,obj_fountain_gui_gems);
gemGui.isAcceptingInput = false;
gemGui.alarm[0] = 1;
global.fountainGui.currentSubMenu = CHOOSEGEM; 