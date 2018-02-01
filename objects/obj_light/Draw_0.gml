if !isRoomDark(room) exit;

if !canSeePlayer(owner) exit;

if( !surface_exists(surf) ){
    surf = surface_create(room_width,room_height);
}
var lx = owner.x;       // the light position, based around the owner location
var ly = owner.y;
var rad = owner.lightRadius;            // the radius of the light
var tile_size = 32;     // size of a tile
var tilemap = layer_tilemap_get_id("walls");


var startx = floor((lx-rad)/tile_size);
var endx = floor((lx+rad)/tile_size);
var starty = floor((ly-rad)/tile_size);
var endy = floor((ly+rad)/tile_size);

//draw_set_color(c_yellow);
//draw_rectangle(startx*tile_size,starty*tile_size, endx*tile_size,endy*tile_size,true);  

surface_set_target(surf);
draw_clear_alpha(0,0);

vertex_begin(VBuffer, VertexFormat);
for(var yy=starty;yy<=endy;yy++)
{
    for(var xx=startx;xx<=endx;xx++)
    {
        var tile = tilemap_get(tilemap,xx,yy);
        if( tile!=0 )
        {
            // get corners of the 
            var px1 = xx*tile_size;     // top left
            var py1 = yy*tile_size;
            var px2 = px1+tile_size;    // bottom right
            var py2 = py1+tile_size;


            if( !SignTest( px1,py1, px2,py1, lx,ly) ){
		        ProjectShadow(VBuffer,  px1,py1, px2,py1, lx,ly );
		    }
		    if( !SignTest( px2,py1, px2,py2, lx,ly) ){
		        ProjectShadow(VBuffer,  px2,py1, px2,py2, lx,ly );
		    }
		    if( !SignTest( px2,py2, px1,py2, lx,ly) ){
		        ProjectShadow(VBuffer,  px2,py2, px1,py2, lx,ly );
		    }
		    if( !SignTest( px1,py2, px1,py1, lx,ly) ){
		        ProjectShadow(VBuffer,  px1,py2, px1,py1, lx,ly );                      
		    }                    
		}
	}
}
vertex_end(VBuffer);    
vertex_submit(VBuffer,pr_trianglelist,-1);
surface_reset_target();

/*if owner.type != CombatantTypes.Player {
	gpu_set_blendmode(bm_add);
} else gpu_set_blendmode(bm_add);*/
//gpu_set_blendmode(bm_add);

shader_set(shader0);
shader_set_uniform_f( LightPosRadius, lx,ly,rad,0.0 );
//draw_surface(surf,0,0);
draw_surface_ext(surf,0,0,1,1,0,color,global.lightColorAlpha);
shader_reset();