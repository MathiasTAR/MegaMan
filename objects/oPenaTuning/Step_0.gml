// Step
x += lengthdir_x(spd, dir);
y += lengthdir_y(spd, dir);
image_angle = dir - 90

if place_meeting(x ,y - 5, oTuning._COLISION){
	instance_destroy(self)	
}
