var _COLISION = layer_tilemap_get_id("tl_cenario");


x += lengthdir_x(spd, dir);
y += lengthdir_y(spd, dir);
image_angle = dir - 90

if place_meeting(x ,y - 30, _COLISION){
	instance_destroy(self)	
}
