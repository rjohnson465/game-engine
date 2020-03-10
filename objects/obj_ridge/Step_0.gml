var udMin = fallDirectionMin;
var udMax = fallDirectionMax;

with obj_combatant_parent {
	// scope: ridge
	with other {
		var t = rectangle_in_rectangle(
			other.bbox_left, other.bbox_top, other.bbox_right, other.bbox_bottom, // combatant bounding box
			bbox_left, bbox_top, bbox_right, bbox_top + 1 // top line of ridge's bbox
		)
		var b = rectangle_in_rectangle(
			other.bbox_left, other.bbox_top, other.bbox_right, other.bbox_bottom, // combatant bounding box
			bbox_left, bbox_bottom, bbox_right, bbox_bottom - 1 // bottom line of ridge's bbox
		)
		var r = rectangle_in_rectangle(
			other.bbox_left, other.bbox_top, other.bbox_right, other.bbox_bottom, // combatant bounding box
			bbox_right, bbox_top, bbox_right - 1, bbox_bottom // right line of ridge's bbox
		)
		var l = rectangle_in_rectangle(
			other.bbox_left, other.bbox_top, other.bbox_right, other.bbox_bottom, // combatant bounding box
			bbox_left, bbox_top, bbox_left + 1, bbox_bottom // left line of ridge's bbox
		)
		
		
		
		if	((t && b) || (l && r)) && layer == other.layer {
			
			// get the intersection rect -- if area v small, do nothing
			var leftX = max(other.bbox_left, bbox_left);
			var rightX = min(other.bbox_right, bbox_right);
			var topY = max(other.bbox_top, bbox_top);
			var bottomY = min(other.bbox_bottom, bbox_bottom);
		
			var area = 0;
			if (leftX < rightX && topY < bottomY) {
				var lx = leftX; var ty = topY;
				var rx = lx + (rightX - leftX); var by = ty + (bottomY - topY);
				var rectw = rx - lx; var recth = by - ty;
				area = rectw * recth;
				
			}
			
			if area > 650 {
				// scope: combatant
				with other {
				
					if angleBetween(udMin,udMax,direction) && !mightFallOffRidge && visible {
					// if angleBetweenClockwise(udMin,udMax,direction) && !mightFallOffRidge {
						var what = angleBetween(udMin, udMax, direction);
						mightFallOffRidge = true;
					} 
	
		
					else if !angleBetween(udMin,udMax,direction) && mightFallOffRidge && visible {
						mightFallOffRidge = false;
					}
				}
			}
		}
	}
	
	// activate ridge for combatant if approaching from the proper direction
	var dirToRidge = point_direction(x,y,other.x,other.y);
	if visible && place_meeting_layer(x, y, other) && angleBetween(udMin, udMax, direction) && angleBetween(udMin, udMax, dirToRidge) {
		
		var doNotAdd = false;
		var ridge = other;
		// make sure there are no other ridges player is touching that would disagree with the curent direction
		with obj_ridge {
			if id == ridge continue;
			if !angleBetween(fallDirectionMin, fallDirectionMax, other.direction) && place_meeting_layer(other.x, other.y, id) {
				doNotAdd = true;
			}
		}
		
		if !doNotAdd && visible {
			if ds_list_find_index(activeRidges, other) == -1 {
				ds_list_add(activeRidges, other);
			}
		}
	}
	
	// maybe remove this ridge from a combatant's "active ridges" list
	if ds_list_size(activeRidges) > 0 && !place_meeting_layer(x, y, other) {
		var index = ds_list_find_index(activeRidges, other);
		if index != -1 {
			ds_list_delete(activeRidges, index);
		}
	}
}
	



/*
if place_meeting_layer(x,y,global.player) && global.player.visible {
	with global.player {

		var dir = direction;
		if angleBetween(udMin,udMax,dir) && !mightFallOffRidge {
			mightFallOffRidge = true;
		} 
	
		
		else if !angleBetween(udMin,udMax,dir) && mightFallOffRidge {
			mightFallOffRidge = false;
		}
	}
}
