var _COLISION = layer_tilemap_get_id("tl_cenario");
var spd = 8;

x += spd * image_xscale;

if (x < 0 || x > room_width || place_meeting(x, y, _COLISION)) {
    instance_destroy();
}
