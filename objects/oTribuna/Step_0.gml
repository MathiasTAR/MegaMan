// Step
var _COLISION = layer_tilemap_get_id("tl_cenario");

// ==========================
// MORTE
// ==========================
if (_vidaBoss <= 0) {
    _vidaBoss = 0;
	if (mover_para(pos_idle[0], pos_idle[1], 0.08)){
		_estado = "Morto";
	}
}

switch (_estado) {
    // ==========================
    // MORTE
    // ==========================
    case "Morto":
        switch (fase_morte) {
            case 0: 
                if (sprite_index != sTribunaMorto) {
                    sprite_index = sTribunaMorto;
                    image_speed = 1; 
                    tempo_morte = 4 * room_speed;
                }
                else if (image_index >= image_number - 1) {
                    image_index = image_number - 1;
                    image_speed = 0;
                    
                    if (tempo_morte > 0) {tempo_morte--;}
                    else 
					{ 
						instance_destroy(); 
						instance_create_layer(x,y - 195,"Player", oPoderEspada)
						oSoundController.theme_Tribuna.play = false
					}
                }
            break;
        }
    break;

    // ==========================
    // IDLE
    // ==========================
    case "Idle":
        if (sprite_index != sIdleTribuna){
			sprite_index = sIdleTribuna;
			image_speed = 1;
			
			if (image_xscale == 1){image_xscale = -1}
		}

        if (cooldown_ataque <= 0 && _vidaBoss > 0 && oPlayer._vidaPlayer > 0) {
            ataque_boss();
        }
    break;

    // ==========================
    // ATAQUES
    // ==========================
    case "Atacando":
        var ataque_atual = padrao_ataque[ultimo_ataque];

        switch (ataque_atual) {
            // --------------------------
            // DASH
            // --------------------------
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
                
                            if (mover_para(pos_idle[0], -100, 0.07)) {
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
                        if (mover_para(pos_alvo[0], pos_alvo[1], 0.12)) {
                            if (sprite_index != sTribunaDash){
                                sprite_index = sTribunaDash;
                                image_speed = 1;
                                timer_fase = room_speed * 0.2; // Pequena pausa antes do dash
                            }
                
                            if (timer_fase > 0) { 
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
                                fx.image_xscale = choose(1, -1);   
                                fx.image_angle = irandom_range(-20, 20); 
                            }
                            else if (x >= room_width - 65) {
                                fase_ataque = 4;
                                timer_fase = room_speed * 0.5; 
                            }
                        } else {
                            // Vindo da direita - dash para esquerda
                            x -= _dash_spd;
                            if (place_meeting(x,y, oPlayer)){
                                var fx = instance_create_layer(oPlayer.x, oPlayer.y, "Fx", oSlashTribuna);
                                fx.image_xscale = choose(1, -1);   
                                fx.image_angle = irandom_range(-20, 20); 
                            }
                            else if (x <= 65) {
                                fase_ataque = 4;
                                timer_fase = 0.5 * room_speed;
                            }
                        }
                    break;
				
                    case 4:
                        if (timer_fase > 0) timer_fase--;
                        else {
                            if (sprite_index != sTribunaPulando){
                                image_xscale *= -1;
                                sprite_index = sTribunaPulando;
                            }
                            else if (image_index >= image_number - 1) {
                                image_index = image_number - 1;
                                image_speed = 0;
                                fase_ataque = 5;
                            }
                        }
                    break;
				
                    case 5:
                        // Volta para a posição idle
                        if (mover_para(pos_idle[0], pos_idle[1], 0.09)){
							sprite_index = sIdleTribuna;
							image_speed = 1;
                            _estado = "Idle";
                            cooldown_ataque = 2 * room_speed;
                        }
                    break;
                }
            break;

            // --------------------------
            // ESPADAS BAIXO
            // --------------------------
            case "Espadas_Baixo":
                switch (fase_ataque) {
                    case 0:
                        if (sprite_index != sTribunaPulando) {
                            sprite_index = sTribunaPulando;
                            image_speed = 1;
                        }
                        else if (image_index >= image_number - 1) {
                            image_index = image_number - 1;
                            image_speed = 0;

                            if (mover_para(pos_alvo[0], pos_alvo[1], 0.1)) {
                                fase_ataque = 1;
                            }
                        }
                    break;

                    case 1:
                        vuneravel = false;
                        if (canto_escolhido == "esquerda_cima"){
                            image_xscale = 1;
                        } else {
                            image_xscale = -1;
                        }
						
                        if (sprite_index != sAtaqueTribunaEspada) {
                            sprite_index = sAtaqueTribunaEspada;
                            image_index = 0;
                            image_speed = 1;
                        }
                        else if (image_index >= image_number - 1) {
                            image_index = image_number - 1;
                            image_speed = 0;

                            espada_baixo1 = instance_create_layer(240, 310, "Ataques", oEspadaTribuna);
                            espada_baixo1.image_xscale = 24;
                            espada_baixo1.y = 310;

                            fase_ataque = 2;
                        }
                    break;

                    case 2:
                        if (instance_exists(espada_baixo1)) {
                            if (espada_baixo1.y > 255) {
                                espada_baixo1.y -= 8;
                            } else {
                                fase_ataque = 3;
                                timer_fase = 1.6 * room_speed;
                            }
                        }
                    break;

                    case 3:
                        if (timer_fase > 0) timer_fase--;
                        else fase_ataque = 4;
                    break;

                    case 4:
                        if (instance_exists(espada_baixo1)) {
                            if (espada_baixo1.y < 310) {
                                espada_baixo1.y += 2;
                            } else {
                                with (espada_baixo1) instance_destroy();
                                fase_ataque = 5;
								vuneravel = true;
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
                        if (mover_para(pos_idle[0], pos_idle[1], 0.09)) {
							sprite_index = sIdleTribuna;
							image_speed = 1;
                            _estado = "Idle";
                            cooldown_ataque = 2 * room_speed;
                        }
                    break;
                }
            break;

            // --------------------------
            // ESPADAS CIMA
            // --------------------------
            case "Espada_Cima":
                switch (fase_ataque){
                    case 0:
                        switch (_espada_cima){
                            case 0:
                                array_push(espadas_cima, instance_create_layer(60, -13, "Fx", oEspadaTribuna));
                                array_push(espadas_cima, instance_create_layer(240, -13, "Fx", oEspadaTribuna));
                                array_push(espadas_cima, instance_create_layer(420, -13, "Fx", oEspadaTribuna));
                                for (var i=0; i<3; i++){ espadas_cima[i].image_xscale = 6; espadas_cima[i].image_yscale = -1; }
                            break;
							
                            case 1:
                                array_push(espadas_cima, instance_create_layer(150, -13, "Fx", oEspadaTribuna));
                                array_push(espadas_cima, instance_create_layer(330, -13, "Fx", oEspadaTribuna));
                                for (var i=0; i<2; i++){ espadas_cima[i].image_xscale = 6; espadas_cima[i].image_yscale = -1; }
                            break;
							
                            case 2:
                                array_push(espadas_cima, instance_create_layer(120, -13, "Fx", oEspadaTribuna));
                                espadas_cima[0].image_xscale = 12; espadas_cima[0].image_yscale = -1;
                            break;
							
                            case 3:
                                array_push(espadas_cima, instance_create_layer(360, -13, "Fx", oEspadaTribuna));
                                espadas_cima[0].image_xscale = 12; espadas_cima[0].image_yscale = -1;
                            break;
							
                            case 4:
                                array_push(espadas_cima, instance_create_layer(100, -13, "Fx", oEspadaTribuna));
                                array_push(espadas_cima, instance_create_layer(378, -13, "Fx", oEspadaTribuna));
                                for (var i=0; i<2; i++){ espadas_cima[i].image_xscale = 10; espadas_cima[i].image_yscale = -1; }
                            break;
                        }
                        fase_ataque = 1;
                    break;
				
                    case 1:
                        if (sprite_index != sAtaqueTribunaEspada){
                            sprite_index = sAtaqueTribunaEspada;
                            image_speed = 1; 
                        }
                        else if (image_index >= image_number - 1) {
                            image_index = image_number - 1;
                            image_speed = 0;
                            fase_ataque = 2;
                        }
                    break;
				
                    case 2:
                        var todas_no_chao = true;
                        for (var i = 0; i < array_length(espadas_cima); i++){
                            if (espadas_cima[i].y < 300){
                                espadas_cima[i].y += 8;
                                todas_no_chao = false;
                            }
                        }
                        if (todas_no_chao) fase_ataque = 3;
                    break;
				
                    case 3:
                        // Destrói todas as espadas e limpa array
                        for (var i = 0; i < array_length(espadas_cima); i++){
                            if (instance_exists(espadas_cima[i])) with (espadas_cima[i]) instance_destroy();
                        }
                        espadas_cima = [];
                        fase_ataque = 4;
                    break;
				
                    case 4:
                        if (mover_para(pos_idle[0], pos_idle[1], 0.09)) {
							sprite_index = sIdleTribuna;
							image_speed = 1;
                            cooldown_ataque = 2 * room_speed;
                            _estado = "Idle";
                        }
                    break;
                }
            break;
        }
    break;

    // ==========================
    // INTRO
    // ==========================
    case "Intro":
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
    break;
}

// ==========================
// INVENCIBILIDADE / PISCAR
// ==========================
if (inv_timer > 0) {
    if (inv_timer div 4 mod 10) image_blend = c_grey;
    else image_blend = c_white;
} else {
    image_blend = c_white;
}

// ==========================
// COOLDOWNS
// ==========================
if (cooldown_ataque > 0) cooldown_ataque--;
if (inv_timer > 0) inv_timer--;
