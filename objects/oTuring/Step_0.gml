var _COLISION = layer_tilemap_get_id("tl_cenario");

if (_vidaBoss <= 0) {_vidaBoss = 0; _estado = "Morto"}


// ==========================
// ESTADOS
// ==========================

if (_estado == "Morto") {
    switch (fase_morte) {
        case 0: 
            if (mover_para(pos_idle[0], pos_idle[1], 0.03)) {
                sprite_index = sMorrendoTuring;
                image_index = 0;
                image_speed = 1;
                fase_morte = 1;
            }
        break;

        case 1: // animação de "morrendo"
            if (image_index >= image_number - 1) {
                image_index = image_number - 1;
                image_speed = 0;
                fase_morte = 2;
            }
        break;

        case 2: // Cai até o chão
            if (mover_para(x, 200, 0.02)) {
                sprite_index = sMortoTuring;
				if (image_index >= image_number - 1) {
	                image_index = image_number - 1;
	                image_speed = 0;
				}
                fase_morte = 3;
				tempo_morte = 4 * room_speed
            }
        break;

        case 3:
            if (tempo_morte > 0){tempo_morte --} 
			else 
				{
					instance_destroy(); 
					instance_create_layer(x,y - 200,"Player", oPoderPena)
					oSoundController.theme_Turing.play = false
				}
        break;
    }
}

else if (_estado == "Idle") {
    // Movimento horizontal
    hs = dir * hsmax;
    x += hs;

    // Verifica limites
    if (x <= limite_esq) {
        x = limite_esq;
        dir = 1;
    } else if (x >= limite_dir) {
        x = limite_dir;
        dir = -1;
    }

    // Sprites
    if (hs != 0) {
        sprite_index = sVoandoIdleTuring;
    } else {
    }

    // Virar sprite
    image_xscale = dir;

    // Chamar ataque quando cooldown acabar
    if (cooldown_ataque <= 0 && _vidaBoss > 0 && oPlayer._vidaPlayer > 0) {
        ataque_boss();
    }
}

else if (_estado == "Atacando") {
    var ataque_atual = padrao_ataque[ultimo_ataque];

    switch (ataque_atual) {
        // ==============================
        // ATAQUE 1: COBRIR TELA
        // ==============================
        case "Cobrir_tela":
            sprite_index = sIdleTuring;
            switch (fase_ataque) {
                case 0: // Vai para o canto
                    if (mover_para(pos_alvo[0], pos_alvo[1], 0.05)) {
                        fase_ataque = 1;
                    }
                break;

                case 1: // Sobe
                    if (mover_para(pos_alvo[0], -500, 0.08)) {
                        var pena = instance_create_layer(pos_alvo[0], -10, "Ataques", oPenaGrandeTuning);
                        pena.image_xscale = 1.25;
                        pena.image_yscale = 10
                        image_yscale = -1;
                        fase_ataque = 2;
                    }
                break;

                case 2: // Desce
                    if (mover_para(pos_alvo[0], 400, 0.03)) {
                        fase_ataque = 3;
                        x = 240;
                        y = -60;
                        image_yscale = 1;
                        timer_fase = room_speed * 1.1; // pausa de 1,5 seg
                    }
                break;

                case 3: 
                    if (timer_fase > 0) {
                        timer_fase--;
                    } else {
                        if (mover_para(pos_idle[0], pos_idle[1], 0.1)) {
                            _estado = "Idle";
                            sprite_index = sIdleTuring;
                            cooldown_ataque = room_speed * 2.3;
                        }
                    }
                break;
            }
        break;

        // ==============================
        // ATAQUE 2: PENAS
        // ==============================
        case "Penas":
		    switch (fase_ataque) {
		        case 0:
		            if (timer_fase <= 1 && penas_restantes > 0) {
		                if (sprite_index != sAtacandopenaTuning) {
		                    sprite_index = sAtacandopenaTuning;
		                    image_index = 0;
		                    image_speed = 1;
		                }

		                var angulo_base = point_direction(x, y, oPlayer.x, oPlayer.y);

		                var pena_meio = instance_create_layer(x, y, "Ataques", oPenaTuning);
		                pena_meio.dir = angulo_base;

		                var pena_esq = instance_create_layer(x, y, "Ataques", oPenaTuning);
		                pena_esq.dir = angulo_base - 30;

		                var pena_dir = instance_create_layer(x, y, "Ataques", oPenaTuning);
		                pena_dir.dir = angulo_base + 30;

		                penas_restantes--;
		                timer_fase = room_speed * 1; // intervalo
		            }
		            else {
		                timer_fase--;

		                if (sprite_index == sAtacandopenaTuning && image_index >= 5) {
		                    sprite_index = sAtacandopenaidleTuning;
		                    image_index = 0;
		                    image_speed = 1;
		                }
		            }

		            // Fim do ataque
		            if (penas_restantes <= 0) {
		                fase_ataque = 1;
		                timer_fase = room_speed * 0.5; // delay final
		            }
		        break;

		        case 1:
		            if (timer_fase > 0) {
		                timer_fase--;
		            } else {
		                sprite_index = sIdleTuring;
		                image_speed = 1;
		                if (mover_para(pos_idle[0], pos_idle[1], 0.1)) {
		                    _estado = "Idle";
		                    image_yscale = 1;
		                    cooldown_ataque = room_speed * 2.3;
		                }
		            }
		        break;
		    }
		break;


        // ==============================
        // ATAQUE 3: INVESTIDA NO PLAYER
        // ==============================
        case "Ataque_rapido_Player":
		    switch (fase_ataque) {
		        case 0: // Carrega mirando no player
		            if (instance_exists(oPlayer)) {
		                if (oPlayer.x > x) image_xscale = 1; else image_xscale = -1;
		            }

					sprite_index = sAtaqueVoandoTuring; 
					if (image_index >= 1){
						image_index = 1
						image_speed = 0;
						timer_fase = 1 * room_speed;
						fase_ataque = 1;
					}
		        break;

		        case 1: // Investida rápida
					if (timer_fase > 0){timer_fase--}
					else{ 
						if (mover_para(pos_alvo[0], pos_alvo[1], 0.07)){
							fase_ataque = 2;
						}
					}
		        break;

		        case 2: // Volta pro Idle
		            if (mover_para(pos_idle[0], pos_idle[1], 0.1)) {
		                _estado = "Idle";
		                sprite_index = sIdleTuring;
		                image_yscale = 1;
						image_speed = 1;
		                cooldown_ataque = room_speed * 2.3;
		            }
		        break;
		    }
		break;
	}
}

else if (_estado == "Intro"){
	image_xscale = -1
	switch (fase_intro) {
		case 0:
			sprite_index = sIntroTuring
			fase_intro = 1
		break;
		
		case 1:
			if (timer_fase >= 0) {timer_fase --}
			else {
				sprite_index = sIdleTuring
				if (mover_para(x, 75, 0.07)) {fase_intro = 2}
			}
		break;
		
		case 2: // Volta pro Idle
			if (mover_para(pos_idle[0], pos_idle[1], 0.05)) {
			_estado = "Idle";
			sprite_index = sIdleTuring;
			image_yscale = 1;
			image_speed = 1;
			cooldown_ataque = room_speed * 2.3;
			}
		break;
	}
}
	
	
	
// Piscar vermelho
if (inv_timer > 0) {
    if (inv_timer div 4) mod 8 {
        image_blend = c_gray;   // vermelho
    }else {image_blend = c_white} // reseta a cor
} else {
    image_blend = c_white; // reseta a cor
}

// ==========================
// COOLDOWN
// ==========================
if (cooldown_ataque > 0) {cooldown_ataque--;};

if (inv_timer > 0) {inv_timer--;}