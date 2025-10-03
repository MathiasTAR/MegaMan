// Colisao com o tileset (chao)
var _COLISION = layer_tilemap_get_id("tl_cenario");

if (_vidaPlayer = 0) {hs = 0}

#region Inputs e Controler Horizontal
// Inputs
if (_vidaPlayer != 0){
	_right  = keyboard_check(vk_right) || gamepad_axis_value(global.gamepad_id, gp_axislh) > global.gamepad_deadzone
	_left   = keyboard_check(vk_left) || gamepad_axis_value(global.gamepad_id, gp_axislh) < -global.gamepad_deadzone
	_jump   = keyboard_check_pressed(vk_up) || keyboard_check_pressed(vk_space) || gamepad_button_check_pressed(0, gp_face1);
	_jump_hold   = keyboard_check(vk_up) || keyboard_check(vk_space) || gamepad_button_check(global.gamepad_id, gp_face1);
	_tiro   = keyboard_check_pressed(ord("Z")) || gamepad_button_check_pressed(global.gamepad_id, gp_face2);
	
	// COlisão e movimento horizontal
	hs = (_right - _left) * hsmax;
	move_and_collide(hs, 0.1, _COLISION, 32);
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
y = clamp(y, 0, room_height  + 30);


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

if (!_jump_hold and vs < 0){
	vs = max(vs, -hsmax / 2)
}

// Colisão Vertical
move_and_collide(0, vs - 0.1, _COLISION,32);
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

if (y >= room_height and _vidaPlayer != 0) {
	_vidaPlayer = 0
	troca_estado(estado_dano);
}


// Timers
if (cooldown_tiro > 0) {cooldown_tiro --}
if (inv_time > 0) {inv_time --}
if (timer_player > 0) {timer_player --}


roda_estado();

if (sala1) {room_goto(room1)}
else if (sala2) {room_goto(Room_Tribuna)}
else if (sala3) {room_goto(room2)}
else if (sala4) {room_goto(room4)}
else if (sala0) {room_goto(Debug)}