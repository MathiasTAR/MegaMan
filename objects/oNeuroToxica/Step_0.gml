/// ==========================
/// STEP EVENTO
/// ==========================
var _COLISION = layer_tilemap_get_id("tl_cenario");

// ==========================
// MORTE
// ==========================
if (_vidaBoss <= 0) {
    _vidaBoss = 0;
    _estado = "Morto";
}


// ==========================
// ESTADOS PRINCIPAIS
// ==========================
switch (_estado) {

    // --------------------------
    // INTRO
    // --------------------------
    case "Intro":
        _estado = "Idle";
    break;


    // --------------------------
    // IDLE
    // --------------------------
    case "Idle":
        // Chamar ataque (teste manual com CTRL)
        if (keyboard_check_pressed(vk_control)) {
            ataque_boss();
        }
    break;


    // --------------------------
    // ATACANDO
    // --------------------------
    case "Atacando":
	    var ataque_atual = padrao_ataque[ultimo_ataque];

	    switch (ataque_atual) {

	        case "Veneno":
	            switch (fase_ataque) {

	                // ======================
	                // Fase 0: Spawn dos venenos
	                // ======================
	                case 0:
	                    venenos_ativos = [];
	                    var qtn_veneno = irandom_range(2, 4);

	                    for (var i = 0; i < qtn_veneno; i++) {
	                        var veneno_X = ultimo_veneno_X;

	                        // Evita repetir o mesmo X
	                        while (veneno_X == ultimo_veneno_X) {
	                            veneno_X = irandom_range(110, 370);
	                        }
	                        ultimo_veneno_X = veneno_X;

	                        var ven = instance_create_layer(veneno_X, y, "Ataques", oVenenoNeuroToxica);
	                        array_push(venenos_ativos, ven);
	                    }

	                    fase_ataque = 1;
	                break;


	                // ======================
	                // Fase 1: Veneno caindo
	                // ======================
	                case 1:
	                    var todos_no_chao = true;

	                    for (var i = 0; i < array_length(venenos_ativos); i++) {
	                        var ven = venenos_ativos[i];

	                        // Testa colisão com o objeto invisível do chão
	                        if (!place_meeting(ven.x, ven.y - 12, oColisao)) {
	                            ven.y += 4;
	                            todos_no_chao = false;
	                        } else {
	                            ven.sprite_index = sVenenoNoChaoNeuroToxica
	                        }
	                    }

	                    if (todos_no_chao) {
							
	                        timer_fase = 2 * room_speed;
	                        fase_ataque = 2;
	                    }
	                break;


	                // ======================
	                // Fase 2: Espera e destrói
	                // ======================
	                case 2:
	                    if (timer_fase > 0) timer_fase--;
	                    else {
	                        for (var i = 0; i < array_length(venenos_ativos); i++) {
	                            if (instance_exists(venenos_ativos[i])) {
	                                instance_destroy(venenos_ativos[i]);
	                            }
	                        }
	                        venenos_ativos = [];
	                        fase_ataque = 3;
	                    }
	                break;


	                // ======================
	                // Fase 3: Finaliza ataque
	                // ======================
	                case 3:
	                    _estado = "Idle";
	                break;
	            }
	        break;
	    }
	break;



    // --------------------------
    // MORTE
    // --------------------------
    case "Morto":
        switch (fase_morte) {
            case 0:
                sprite_index = sMorrendoAranha;
                image_index = 0;
                image_speed = 0.8;
                tempo_morte = 3 * room_speed;
                fase_morte = 1;
            break;

            case 1:
                if (image_index >= image_number - 1) {
                    image_index = image_number - 1;
                    image_speed = 0;
                    if (tempo_morte > 0) tempo_morte--;
                    else instance_destroy();
                }
            break;
        }
    break;
}


// ==========================
// PISCAR DE DANO
// ==========================
if (inv_timer > 0) {
    if (inv_timer div 4 mod 6) image_blend = c_grey;
    else image_blend = c_white;
} else {
    image_blend = c_white;
}

// ==========================
// COOLDOWNS
// ==========================
if (cooldown_ataque > 0) cooldown_ataque--;
if (inv_timer > 0) inv_timer--;
