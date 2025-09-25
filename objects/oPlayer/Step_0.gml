var move_x = keyboard_check(vk_right) - keyboard_check(vk_left);
var jump   = keyboard_check_pressed(vk_up) || keyboard_check_pressed(vk_space);
var tiro   = keyboard_check_pressed(ord("Z"));

// Movimento eixo X
var hsp = move_x * hs;

// Colisão horizontal
if (!place_meeting(x + hsp, y, COL_OBJ)) {
    x += hsp;
} else {
    while (!place_meeting(x + sign(hsp), y, COL_OBJ)) {
        x += sign(hsp);
    }
}

// Virar Sprite
if (move_x != 0) image_xscale = sign(move_x);


// Gravidade
vs += global.PlayerStats.grav;
vs = clamp(vs, -global.PlayerStats.pulo_vel, global.PlayerStats.queda_max);

// Pulo
if (jump && no_chao) {
    vs = -global.PlayerStats.pulo_vel;
    no_chao = false;
}

// Colisão Vertical
if (!place_meeting(x, y + vs, COL_OBJ)) {
    y += vs;
    no_chao = false;
} else {
    while (!place_meeting(x, y + sign(vs), COL_OBJ)) {
        y += sign(vs);
    }
    if (vs > 0) { // chão
        no_chao = true;
    }
    vs = 0;
}

if (tiro and cooldown_tiro == 0) {
    var bullet = instance_create_layer(x, y, "Instances", oBullet);
    bullet.image_xscale = image_xscale;
	cooldown_tiro = 15;
	estado = Estado.Atirando;
}
if (cooldown_tiro > 0){cooldown_tiro -= 1}

// ESTADOS

if (tiro) {
    if (!no_chao and jump) {
        estado = Estado.PulandoAtirando;
    }
    else if (move_x != 0) {
        estado = Estado.CorrendoAtirando;
    }

}
else {
    if (!no_chao) {
        if (vs < 0) {
            estado = Estado.Pulando;
        }
    }
    else {
        if (move_x != 0) {
            estado = Estado.Correndo;
        }
        else {
            estado = Estado.Idle;
        }
    }
}

