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
            if (sprite_index != sTribunaMorto){
				sprite_index = sTribunaMorto;
				image_speed = 1; 
				tempo_morte = 4 * room_speed
			}
			else if (image_index >= image_number - 1) {
				image_index = image_number - 1;
				image_speed = 0;
				
				if (tempo_morte > 0) {tempo--}
				else{instance_destroy()}
			}
			
        break;
    }
}

// ==========================
// IDLE
// ==========================
else if (_estado == "Idle") {
    sprite_index = sIdleTribuna;

    // Chamar ataque (temporário: tecla de debug)
    //if (keyboard_check_pressed(vk_control)) {
    //    ataque_boss();
    //}
	
	if (cooldown_ataque <= 0 && _vidaBoss > 0 && oPlayer._vidaPlayer > 0) {
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
            
		            else if (image_index >= image_number - 1) {
		                image_index = image_number - 1;
		                image_speed = 0;
                
		                if (mover_para(pos_idle[0], -100, 0.05)) {
		                    fase_ataque = 1;
		                }
		            }
		        break;
    
		        case 1:
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
		        break;
    
		        case 2:
		            // Entra devagar na tela vindo do canto
		            if (mover_para(pos_alvo[0], pos_alvo[1], 0.1)) {
		                if (sprite_index != sTribunaDash){
		                    sprite_index = sTribunaDash;
		                    image_speed = 1;
		                    timer_fase = room_speed * 0.2; // Pequena pausa antes do dash
		                }
                
		                if (timer_fase >= 0) { 
		                    timer_fase--; 
		                } else {
		                    fase_ataque = 3;
		                }
		            }
		        break;
        
		        case 3:
		            var _dash_spd = 40;
            
		            if (image_xscale == 1) {
		                // Vindo da esquerda - dash para direita
		                x += _dash_spd;
						if (place_meeting(x,y, oPlayer)){
							var fx = instance_create_layer(oPlayer.x, oPlayer.y, "Fx", oSlashTribuna);
							fx.image_xscale = choose(1, -1);   // espelha horizontal
							fx.image_angle = irandom_range(-20, 20); // ângulo aleatório
						}
						
		                else if (x >= room_width - 65) {
		                    fase_ataque = 4;
		                    timer_fase = room_speed * 0.5; // Pausa antes de voltar ao idle
		                }
		            } else {
		                // Vindo da direita - dash para esquerda
		                x -= _dash_spd;
						if (place_meeting(x,y, oPlayer)){
							var fx = instance_create_layer(oPlayer.x, oPlayer.y, "Fx", oSlashTribuna);
							fx.image_xscale = choose(1, -1);   // espelha horizontal
							fx.image_angle = irandom_range(-20, 20); // ângulo aleatório
						}
		                else if (x <= 65) {
		                    fase_ataque = 4;
							timer_fase = 0.5 * room_speed;
		                }
		            }
		        break;
				
				case 4:
					if (timer_fase > 0) {timer_fase--}
					else{
						if (sprite_index != sTribunaPulando){
							image_xscale = image_xscale * -1
			                sprite_index = sTribunaPulando;
						}
							
						else if (image_index >= image_number - 1) {
							image_index = image_number - 1;
							image_speed = 0;
							fase_ataque = 5
						}
					}
					
				break;
				
		        case 5:
					// Volta para a posição idle
					if (mover_para(pos_idle[0], pos_idle[1], 0.07)){
						cooldown_ataque = 1.5 * room_speed;
						_estado = "Idle";
					}

		        break;
		    }
		break;

		case "Espadas_Baixo":
		    switch (fase_ataque) {
		        case 0:
		            // Boss sobe para o canto escolhido
		            if (sprite_index != sTribunaPulando) {
		                sprite_index = sTribunaPulando;
		                image_speed = 1;
		            }
		            else if (image_index >= image_number - 1) {
		                image_index = image_number - 1;
		                image_speed = 0;

		                if (mover_para(pos_alvo[0], pos_alvo[1], 0.09)) {
		                    fase_ataque = 1;
		                }
		            }
		        break;

		        case 1:
		            // Troca para sprite de ataque com espada
					vuneravel = false
					if (canto_escolhido = "esquerda_cima"){
						image_xscale = 1
					}else{image_xscale = -1}
					
		            if (sprite_index != sAtaqueTribunaEspada) {
		                sprite_index = sAtaqueTribunaEspada;
		                image_index = 0;
		                image_speed = 1;
		            }
		            else if (image_index >= image_number - 1) {
		                image_index = image_number - 1;
		                image_speed = 0;

		                // Cria espada no centro e guarda referência
		                espada_baixo1 = instance_create_layer(240, 310, "Ataques", oEspadaTribuna);
						espada_baixo1 = instance_create_layer(240, 310, "Ataques", oEspadaTribuna);
		                espada_baixo1.image_xscale = 24;
		                espada_baixo1.y = 310;

		                fase_ataque = 2;
		            }
		        break;

		        case 2:
		            // Espada DESCENDO
		            if (instance_exists(espada_baixo1)) {
		                if (espada_baixo1.y > 255) {
		                    espada_baixo1.y -= 8;
		                } else {
		                    fase_ataque = 3;
		                    timer_fase = 1.6 * room_speed; // pausa com espada embaixo
		                }
		            }
		        break;

		        case 3:
		            // Espera com a espada embaixo
		            if (timer_fase > 0) {
		                timer_fase--;
		            } else {
		                fase_ataque = 4;
		            }
		        break;

		        case 4:
		            // Espada SUBINDO / sumindo
		            if (instance_exists(espada_baixo1)) {
		                if (espada_baixo1.y < 310) {
		                    espada_baixo1.y += 2;
		                } else {
		                    with (espada_baixo1) instance_destroy();
		                    fase_ataque = 5;
		                }
		            }
		        break;

		        case 5:
					if (sprite_index != sTribunaPulando) {
						sprite_index = sTribunaPulando;
						image_index = 0;
						image_speed = 1;
					}
					else if (image_index >= image_number - 1) {
						image_index = image_number - 1;
						image_speed = 0;
						fase_ataque = 6;
					}
		        break;

		        case 6:
		            // Volta para a posição idle
		            if (mover_para(pos_idle[0], pos_idle[1], 0.08)) {
		                cooldown_ataque = 1 * room_speed;
		                _estado = "Idle";
						vuneravel = true
		            }
		        break;
		    }
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
	image_xscale = -1;
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