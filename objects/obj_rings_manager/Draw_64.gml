var r1 = getItemInEquipmentSlot(EquipmentSlots.RightRing1);
var r2 = getItemInEquipmentSlot(EquipmentSlots.RightRing2);
var r3 = getItemInEquipmentSlot(EquipmentSlots.LeftRing1);
var r4 = getItemInEquipmentSlot(EquipmentSlots.LeftRing2);

var rings = [r1, r2, r3, r4];
var p = global.player;
ringsCount = 0;
for (var i = 0; i < array_length_1d(rings); i++) {
	ringsActive[i] = noone;
	var ring = rings[i];
	if !instance_exists(ring) continue;
	var doShow = false;
	
	switch ring.object_index {
		
		case obj_item_ring_wolftoothring: {
			// show wolftooth ring if hp below 25%
			doShow = p.hp <= .25 * p.maxHp;
			break;
		}
	
	}
	
	if doShow {
		ringsActive[i] = ring;
		ringsCount++;
		draw_sprite_ext(spr_item_slot, 1, 10 + ((ringsCount-1)*32) + 5, 100-59, .5, .5, 0, c_white, 1);
		draw_sprite_ext(ring.itemSprite, 1, 10 + ((ringsCount-1)*32) + 5, 100-59, .5, .5, 0, c_white, 1);
	}

}
