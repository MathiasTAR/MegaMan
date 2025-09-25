x += spd * image_xscale;

if (x < 0 || x > room_width || place_meeting(x ,y, Colision)) {
    instance_destroy();
}