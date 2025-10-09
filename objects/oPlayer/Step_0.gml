// ==========================
// Colisão com o tileset (chão)
// ==========================
//var _COLISION = layer_tilemap_get_id("tl_cenario");

var _COLISION = [layer_tilemap_get_id("tl_cenario"), layer_tilemap_get_id("tl_cenario_1")]

// ==========================
// Função de movimentação com colisão
// ==========================
function move_axis(_hs, _vs, _colisao) {
    // Horizontal
    if (_hs != 0) {
        var _sign = sign(_hs);
        for (var i = 0; i < abs(_hs); i++) {
            if (!place_meeting(x + _sign, y, _colisao)) x += _sign;
            else break;
        }
    }

    // Vertical
    if (_vs != 0) {
        var _sign = sign(_vs);
        for (var i = 0; i < abs(_vs); i++) {
            if (!place_meeting(x, y + _sign, _colisao)) y += _sign;
            else break;
        }
    }
}

// ==========================
// Inputs e Controle Horizontal
// ==========================
if (_vidaPlayer == 0) { 
    hs = 0; 
    vs = 0;
} else {
    _right  = keyboard_check(vk_right) || gamepad_axis_value(global.gamepad_id, gp_axislh) > global.gamepad_deadzone;
    _left   = keyboard_check(vk_left)  || gamepad_axis_value(global.gamepad_id, gp_axislh) < -global.gamepad_deadzone;
    _jump   = keyboard_check_pressed(vk_up) || keyboard_check_pressed(vk_space) || gamepad_button_check_pressed(global.gamepad_id, gp_face1);
    _jump_hold = keyboard_check(vk_up) || keyboard_check(vk_space) || gamepad_button_check(global.gamepad_id, gp_face1);
    _tiro   = keyboard_check_pressed(ord("Z")) || gamepad_button_check_pressed(global.gamepad_id, gp_face2);

    hs = (_right - _left) * hsmax;

    move_axis(hs, 0, _COLISION);
}

// ==========================
// Máquina de estados
// ==========================
roda_estado();

// Virar sprite
if (hs != 0) oPlayer.image_xscale = sign(hs);

// Limitar dentro da room
x = clamp(x, 15, room_width - 15);
y = clamp(y, 0, room_height + 30);

// ==========================
// Controle Vertical
// ==========================
no_chao = place_meeting(x, y + 2, _COLISION);

if (_jump && no_chao) {
    vs = -vsmax;
    oSoundController.sfx_jump.play = true;
    no_chao = false;
} else if (!no_chao) {
    vs += grav;
    vs = clamp(vs, -vsmax, vsmax);
} else {
    vs = 0;
}

// Limitar pulo quando soltar botão
if (!_jump_hold && vs < 0) {
    vs = max(vs, -hsmax / 2);
}

// Aplicar movimentação vertical
move_axis(0, vs, _COLISION);

// ==========================
// Tiro
// ==========================
if (_tiro && cooldown_tiro == 0) {
    var bullet = instance_create_layer(x, y + 2, "Player", oBullet);
    bullet.image_xscale = image_xscale;
    oSoundController.sfx_tiro.play = true;
    cooldown_tiro = 8;
}

// ==========================
// Knockback e Invencibilidade
// ==========================
if (kb_timer > 0) {
    kb_timer--;
    x += lengthdir_x(kb_force, kb_dir);
}

if (inv_timer > 0) {
    image_alpha = (inv_timer div 4) mod 2;
    inv_timer--;
} else {
    image_alpha = 1;
}

// ==========================
// Verificação morte e queda
// ==========================
if (timer_player <= 0 && _vidaPlayer == 0) {
    game_restart();
}

if (y >= room_height && _vidaPlayer != 0) {
    _vidaPlayer = 0;
    troca_estado(estado_dano);
}

// ==========================
// Timers
// ==========================
if (cooldown_tiro > 0) cooldown_tiro--;
if (inv_time > 0) inv_time--;
if (timer_player > 0) timer_player--;
