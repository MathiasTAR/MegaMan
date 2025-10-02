// Step
var _COLISION = layer_tilemap_get_id("tl_cenario");

// ==========================
// MORTE
// ==========================
if (_vidaBoss <= 0) {
    _vidaBoss = 0;
    _estado = "Morto";
}

if (_estado == "Morto") {
    switch (fase_morte) {
        case 0: 
            show_debug_message("Morrendo - Fazendo");
        break;
    }
}

// ==========================
// IDLE
// ==========================
else if (_estado == "Idle") {
    sprite_index = sIdleTribuna;

    // Chamar ataque (temporário: tecla de debug)
    if (keyboard_check_pressed(vk_control)) {
        ataque_boss();
    }
}

// ==========================
// ATAQUES
// ==========================
else if (_estado == "Atacando") {
    var ataque_atual = padrao_ataque[ultimo_ataque];

    switch (ataque_atual) {
        case "Dash":
		    switch (fase_ataque) {
    
		        case 0: 
		            if (sprite_index != sTribunaPulando){
		                sprite_index = sTribunaPulando;
		                image_speed = 1; 
		            }
            
		            if (image_index >= image_number - 1) {
		                image_index = image_number - 1;
		                image_speed = 0;
                
		                // Só sobe depois de chegar no último frame
		                if (mover_para(pos_idle[0], -100, 0.05)) {
		                    fase_ataque = 1;
		                    timer_fase = room_speed * 0.5; // Pequena pausa antes de teleportar
		                }
		            }
		        break;
    
		        case 1:
		            if (timer_fase > 0) {
		                timer_fase--;
		            } else {
		                // Teleporta para fora da tela em um canto aleatório
		                switch (canto_escolhido) {
		                    case "esquerda": 
		                        x = -100; y = pos_alvo[1]; image_xscale = 1; break;
		                    case "esquerda_cima":
		                        x = -100; y = pos_alvo[1]; image_xscale = 1; break;
		                    case "direita":
		                        x = room_width + 100; y = pos_alvo[1]; image_xscale = -1; break;
		                    case "direita_cima":
		                        x = room_width + 100; y = pos_alvo[1]; image_xscale = -1; break;
		                }
		                fase_ataque = 2;
		            }
		        break;
    
		        case 2:
		            // Entra devagar na tela vindo do canto
		            if (mover_para(pos_alvo[0], pos_alvo[1], 0.08)) {
		                if (sprite_index != sTribunaDash){
		                    sprite_index = sTribunaDash;
		                    image_speed = 1;
		                    timer_fase = room_speed * 1; // Pequena pausa antes do dash
		                }
                
		                if (timer_fase >= 0) { 
		                    timer_fase--; 
		                } else {
		                    fase_ataque = 3;
		                }
		            }
		        break;
        
		        case 3:
		            var _dash_spd = 5;
            
		            if (image_xscale == 1) {
		                // Vindo da esquerda - dash para direita
		                x += _dash_spd;
		                if (x >= room_width - 65) {
		                    fase_ataque = 4;
		                    timer_fase = room_speed * 0.5; // Pausa antes de voltar ao idle
		                }
		            } else {
		                // Vindo da direita - dash para esquerda
		                x -= _dash_spd;
		                if (x <= 65) {
		                    fase_ataque = 4;
		                    timer_fase = room_speed * 0.5; // Pausa antes de voltar ao idle
		                }
		            }
		        break;
				
				case 4:
					sprite_index = sIdleTribuna
					fase_ataque = 5
					
				break;
				
		        case 5:
		            if (timer_fase > 0) {
		                timer_fase--;
		            } else {
		                // Volta para a posição idle
		                if (mover_para(pos_idle[0], pos_idle[1], 0.1)) {
		                    _estado = "Idle";
		                    cooldown_ataque = 1 * room_speed;
		                }
		            }
		        break;
		    }
		break;

        case "Penas":
            // <<<--- penas code aqui (igual ao seu)
        break;

        case "Ataque_rapido_Player":
            // <<<--- investida rápida code aqui (igual ao seu)
        break;
    }
}

// ==========================
// INTRO
// ==========================
else if (_estado == "Intro") {
    switch (fase_intro) {
        case 0: 
            sprite_index = sIntroTribuna;
            if (image_index >= image_number - 1) {
                image_index = image_number - 1;
                image_speed = 0;
                fase_intro = 1;
            }
        break;

        case 1: 
            image_speed = 1;
            _estado = "Idle";
        break;
    }
}

// ==========================
// INVENCIBILIDADE / PISCAR
// ==========================
if (inv_timer > 0) {
    if (inv_timer div 4 mod 10) {
        image_blend = c_grey;
    } else {
        image_blend = c_white;
    }
} else {
    image_blend = c_white;
}

// ==========================
// COOLDOWNS
// ==========================
if (cooldown_ataque > 0) cooldown_ataque--;
if (inv_timer > 0) inv_timer--;