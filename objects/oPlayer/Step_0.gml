// Colisao com o tileset (chao)
var _COLISION = layer_tilemap_get_id("tl_cenario");

// Inputs
_right  = keyboard_check(vk_right);
_left   = keyboard_check(vk_left);
_jump   = keyboard_check_pressed(vk_up) || keyboard_check_pressed(vk_space);
_tiro    = keyboard_check_pressed(ord("Z"));
var sala1   = keyboard_check_pressed(ord("1"));
var sala2   = keyboard_check_pressed(ord("2"));
var sala3   = keyboard_check_pressed(ord("3"));
var sala4   = keyboard_check_pressed(ord("4"));
var sala0   = keyboard_check_pressed(ord("0"));


// Máquina de estados
roda_estado();

// Movimento Horizontal
hs = (_right - _left) * hsmax;
move_and_collide(hs, 0, _COLISION, 12);

// Virar Sprite
if (hs != 0) oPlayer.image_xscale = sign(hs);
//if (_right == 1) {image_xscale = -0.05}else{image_xscale = 0.05}

// Verifica se está no chão
no_chao = place_meeting(x, y + 2, _COLISION);

// Pulo e Gravidade
if (!no_chao) {
    vs += grav;
} else {
    vs = 0;
    if (_jump) {
        vs = -vsmax;
    }
}

// Colisão Vertical
move_and_collide(0, vs, _COLISION, 20);

if (_tiro && cooldown_tiro == 0) {
    var bullet = instance_create_layer(x, y - 2, "Instances", oBullet);
    bullet.image_xscale = image_xscale;
    cooldown_tiro = 10;
}

if (cooldown_tiro > 0) {cooldown_tiro -= 1};

roda_estado();

if (sala1) {room_goto(room1)}
else if (sala2) {room_goto(room2)}
else if (sala3) {room_goto(room3)}
else if (sala4) {room_goto(room4)}
else if (sala0) {room_goto(room0)}