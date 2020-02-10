var ring = instance_create_depth(x,y,1,obj_item_ring);
addItemProperty(ring, ModifiableProperties.HpRegen, 1);
appraiseItem(ring);
ds_list_add(items, ring);