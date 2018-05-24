/// buySell
/// must be called by conversation
owner.showBuySell = !owner.showBuySell;
global.owner = owner;
instance_create_depth(x,y,1,obj_buy_sell);