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
                    // Fase 0: Inicialização
                    // ======================
                    case 0:
                        venenos_ativos = [];
                        qtn_veneno = irandom_range(2, 4);
                        veneno_index = 0;
                        delay_veneno = 0; // Começar imediatamente
                        fase_ataque = 1;
                    break;

                    // ======================
                    // Fase 1: Criar venenos sequencialmente na boca da aranha
                    // ======================
                    case 1:
                        if (delay_veneno > 0) {
                            delay_veneno--;
                        } else {
                            if (veneno_index < qtn_veneno) {
                                // Criar veneno na posição da boca da aranha
                                var boca_x = room_width/2; // Posição X da aranha
                                var boca_y = y + 25; // Ajuste para a altura da boca
                                
                                // Criar veneno na boca da aranha
                                var ven = instance_create_layer(boca_x, boca_y, "Ataques", oVenenoNeuroToxica);
                                
                                // Configurar estado inicial como "NaBoca"
                                ven.estado_veneno = "NaBoca";
                                ven.veneno_index = veneno_index; // Para controle individual
                                
                                // Definir posição X aleatória como alvo (evitar repetição)
                                var target_x = ultimo_veneno_X;
                                while (abs(target_x - ultimo_veneno_X) < 50 && qtn_veneno > 1) {
                                    target_x = irandom_range(110, 370);
                                }
                                ultimo_veneno_X = target_x;
                                ven.target_x = target_x;
                                
                                // Altura alvo (mais alta que a posição final)
                                ven.altura_alvo = y - irandom_range(0, 50);
                                
                                array_push(venenos_ativos, ven);
                                veneno_index++;
                                
                                // Delay entre criar um veneno e outro
                                delay_veneno = 0.8 * room_speed; // 0.8 segundos entre venenos
                                
                                // Mudar sprite da aranha para "cuspindo" se quiser
                                // sprite_index = sAranhaCuspindo;
                            } else {
                                // Todos os venenos criados, mudar para próxima fase
                                fase_ataque = 2;
                                timer_fase = 0.5 * room_speed; // Pequeno delay antes de começar movimento
                            }
                        }
                    break;

                    // ======================
                    // Fase 2: Venenos sendo arremessados
                    // ======================
                    case 2:
                        if (timer_fase > 0) {
                            timer_fase--;
                        } else {
                            var todos_arremessados = true;
                            
                            for (var i = 0; i < array_length(venenos_ativos); i++) {
                                var ven = venenos_ativos[i];
                                
                                if (ven.estado_veneno == "NaBoca") {
                                    // Iniciar movimento de arremesso
                                    ven.estado_veneno = "Arremessando";
                                    ven.sprite_index = sVenenoCaindoNeuroToxica;
                                    ven.image_index = 0;
                                    ven.image_speed = 0.5;
                                    
                                    // Calcular trajetória parabólica
                                    var start_x = ven.x;
                                    var start_y = ven.y;
                                    var target_x = ven.target_x;
                                    var peak_y = ven.altura_alvo; // Ponto mais alto
                                    
                                    // Parâmetros da parábola
                                    ven.arremesso_t = 0;
                                    ven.arremesso_speed = 0.03;
                                    ven.arremesso_start_x = start_x;
                                    ven.arremesso_start_y = start_y;
                                    ven.arremesso_peak_x = (start_x + target_x) / 2;
                                    ven.arremesso_peak_y = peak_y;
                                    ven.arremesso_target_x = target_x;
                                    
                                    todos_arremessados = false;
                                }
                                else if (ven.estado_veneno == "Arremessando") {
                                    // Continuar movimento parabólico
                                    ven.arremesso_t += ven.arremesso_speed;
                                    
                                    if (ven.arremesso_t < 1) {
                                        // Fórmula da curva de Bézier quadrática para trajetória suave
                                        var mt = 1 - ven.arremesso_t;
                                        ven.x = mt * mt * ven.arremesso_start_x + 
                                               2 * mt * ven.arremesso_t * ven.arremesso_peak_x + 
                                               ven.arremesso_t * ven.arremesso_t * ven.arremesso_target_x;
                                        ven.y = mt * mt * ven.arremesso_start_y + 
                                               2 * mt * ven.arremesso_t * ven.arremesso_peak_y + 
                                               ven.arremesso_t * ven.arremesso_t * ven.altura_alvo;
                                        todos_arremessados = false;
                                    } else {
                                        // Chegou ao ponto alto, começar a cair
                                        ven.estado_veneno = "Caindo";
                                        ven.x = ven.arremesso_target_x;
                                        ven.y = ven.altura_alvo;
                                    }
                                }
                                else if (ven.estado_veneno == "Caindo") {
                                    // Verificar se chegou no chão
                                    if (!place_meeting(ven.x, ven.y + 4, oColisao)) {
                                        ven.y += 4; // Velocidade de queda
                                        todos_arremessados = false;
                                    } else {
                                        // Colidiu com o chão
                                        ven.estado_veneno = "NoChao";
                                        ven.sprite_index = sVenenoNoChaoNeuroToxica;
                                        ven.image_speed = 0;
                                        ven.image_index = 0;
                                    }
                                }
                            }
                            
                            if (todos_arremessados) {
                                timer_fase = 2 * room_speed; // 2 segundos no chão
                                fase_ataque = 3;
                            }
                        }
                    break;

                    // ======================
                    // Fase 3: Espera no chão
                    // ======================
                    case 3:
                        if (timer_fase > 0) {
                            timer_fase--;
                        } else {
                            // Destruir todos os venenos
                            for (var i = 0; i < array_length(venenos_ativos); i++) {
                                if (instance_exists(venenos_ativos[i])) {
                                    instance_destroy(venenos_ativos[i]);
                                }
                            }
                            venenos_ativos = [];
                            fase_ataque = 4;
                        }
                    break;

                    // ======================
                    // Fase 4: Finaliza ataque
                    // ======================
                    case 4:
                        _estado = "Idle";
                        cooldown_ataque = 3.5 * room_speed; // Reset cooldown
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