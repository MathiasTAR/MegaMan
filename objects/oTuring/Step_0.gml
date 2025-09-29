// Inherit parent
event_inherited();

var _COLISION = layer_tilemap_get_id("tl_cenario");

// ==========================
// ESTADOS
// ==========================
if (_estado == "Idle") {
    // Movimento horizontal
    hs = dir * hsmax;
    x += hs;

    // Verifica limites
    if (x <= limite_esq) {
        x = limite_esq;
        dir = 1;
        image_index = 0;
    } else if (x >= limite_dir) {
        x = limite_dir;
        dir = -1;
        image_index = 0;
    }

    // Sprites
    if (hs != 0) {
        sprite_index = sVoandoIdleTuring;
        image_speed = 1;
    } else {
        image_speed = 1;
    }

    // Virar sprite
    image_xscale = dir;

    // Chamar ataque quando cooldown acabar
    if (cooldown_ataque <= 0) {
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
            sprite_index = sIdleTuning;
            switch (fase_ataque) {
                case 0: // Vai para o canto
                    if (mover_para(pos_alvo[0], pos_alvo[1], 0.05)) {
                        fase_ataque = 1;
                    }
                break;

                case 1: // Sobe
                    if (mover_para(pos_alvo[0], -300, 0.08)) {
                        var pena = instance_create_layer(pos_alvo[0], -200, "Ataques", oPenaGrandeTuning);
                        pena.image_xscale = 6;
                        pena.image_yscale = 20;
                        image_yscale = -1;
                        fase_ataque = 2;
                    }
                break;

                case 2: // Desce
                    if (mover_para(pos_alvo[0], 400, 0.05)) {
                        fase_ataque = 3;
                        x = 240;
                        y = -60;
                        image_yscale = 1;
                        timer_fase = room_speed * 1.5; // pausa de 1,5 seg
                    }
                break;

                case 3: 
                    if (timer_fase > 0) {
                        timer_fase--;
                    } else {
                        if (mover_para(pos_idle[0], pos_idle[1], 0.1)) {
                            _estado = "Idle";
                            sprite_index = sIdleTuning;
                            cooldown_ataque = room_speed * 2;
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
                    sprite_index = sAtacandoTuning;
                    image_index = 0;
                    image_speed = 1;

                    if (timer_fase <= 0 && penas_restantes > 0) {
                        // Cria penas
                        var pena_meio = instance_create_layer(x, y, "Ataques", oPenaTuning);
                        pena_meio.dir = point_direction(x, y, oPlayer.x, oPlayer.y);

                        var pena_esq = instance_create_layer(x, y, "Ataques", oPenaTuning);
                        pena_esq.dir = point_direction(x, y, oPlayer.x, oPlayer.y) - 30;

                        var pena_dir = instance_create_layer(x, y, "Ataques", oPenaTuning);
                        pena_dir.dir = point_direction(x, y, oPlayer.x, oPlayer.y) + 30;

                        penas_restantes--;
                        timer_fase = room_speed * 0.8; // intervalo entre rodadas
                    } else {
                        timer_fase--;
                    }

                    if (penas_restantes <= 0) {
                        fase_ataque = 1;
                        timer_fase = room_speed * 0.5; // tempo extra pra anim
                    }
                break;

                case 1:
                    if (timer_fase > 0) {
                        timer_fase--;
                    } else {
                        sprite_index = sIdleTuning;
                        if (mover_para(pos_idle[0], pos_idle[1], 0.1)) {
                            _estado = "Idle";
                            image_yscale = 1;
                            cooldown_ataque = room_speed * 2;
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
					if (oPlayer.x > x) {image_xscale = 1} else {image_xscale = -1}
                    if (mover_para(pos_idle[0], pos_idle[1], 0.05)) {
                        if (instance_exists(oPlayer)) {
                            pos_alvo = [oPlayer.x, oPlayer.y];
                        }
                        fase_ataque = 1;
                    }
                break;

                case 1: // Investida rápida
                    if (mover_para(pos_alvo[0], pos_alvo[1], 0.09)) {
                        fase_ataque = 2;
                    }
                break;

                case 2: // Volta pro Idle
                    if (mover_para(pos_idle[0], pos_idle[1], 0.1)) {
                        _estado = "Idle";
                        sprite_index = sIdleTuning;
                        image_yscale = 1;
                        cooldown_ataque = room_speed * 2;
                    }
                break;
            }
        break;
    }
}

// ==========================
// COOLDOWN
// ==========================
if (cooldown_ataque > 0) cooldown_ataque--;
