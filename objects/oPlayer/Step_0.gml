// Colisao com o tileset (chao)
var _COLISION = layer_tilemap_get_id("tl_cenario");

if (_vidaPlayer = 0) {hs = 0}

#region Inputs e Controler Horizontal
// Inputs
if (_vidaPlayer != 0){
	_right  = keyboard_check(vk_right);
	_left   = keyboard_check(vk_left);
	_jump   = keyboard_check_pressed(vk_up) || keyboard_check_pressed(vk_space);
	_tiro   = keyboard_check_pressed(ord("Z"));
	
	// COlisão e movimento horizontal
	hs = (_right - _left) * hsmax;
	move_and_collide(hs, 0, _COLISION, 12);
}

var sala1   = keyboard_check_pressed(ord("1"));
var sala2   = keyboard_check_pressed(ord("2"));
var sala3   = keyboard_check_pressed(ord("3"));
var sala4   = keyboard_check_pressed(ord("4"));
var sala0   = keyboard_check_pressed(ord("0"));

#endregion

// Máquina de estados
roda_estado();

// Virar Sprite
if (hs != 0) oPlayer.image_xscale = sign(hs);
x = clamp(x, 15, room_width  - 15);


#region Controler Vertical

if (_jump and no_chao){oSoundController.sfx_jump.play = true}
// Verifica se está no chão
no_chao = place_meeting(x, y + 2, _COLISION);

// Pulo e Gravidade
if (!no_chao && estado_atual != estado_dano) {
    vs += grav;
} else {
    vs = 0;
    if (_jump) {
        vs = -vsmax;
    }
}

// Colisão Vertical
move_and_collide(0, vs, _COLISION, 20);
#endregion

#region Tiro
if (_tiro && cooldown_tiro == 0) {
    var bullet = instance_create_layer(x, y+2, "Player", oBullet);
    bullet.image_xscale = image_xscale;
	oSoundController.sfx_tiro.play = true
    cooldown_tiro = 8;
}
#endregion

#region KnockBack e Invecibilidade
// Knockback ativo
if (kb_timer > 0) {
    kb_timer--;
    x += lengthdir_x(kb_force, kb_dir);
}

// Invencibilidade piscando
if (inv_timer > 0) {
	image_alpha = (inv_timer div 4) mod 2; // pisca
    inv_timer--;
} else {
    image_alpha = 1;
}
#endregion

if (timer_player <= 0 and _vidaPlayer = 0){
	game_restart();
};

// Timers
if (cooldown_tiro > 0) {cooldown_tiro --};
if (inv_time > 0) {inv_time --}
if (timer_player > 0) {timer_player --}


roda_estado();

if (sala1) {room_goto(room1)}
else if (sala2) {room_goto(room2)}
else if (sala3) {room_goto(room3)}
else if (sala4) {room_goto(room4)}
else if (sala0) {room_goto(Debug)}