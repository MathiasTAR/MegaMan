/// ==========================
/// Variáveis principais
/// ==========================
padrao_ataque = ["Dash", "Dash", "Dash"];

_vidaBoss = 100;

image_xscale = -1;
x = 239.5;
y = 168;

ultimo_ataque = -1;
ultimo_canto = -1;

_estado = "Intro";
fase_ataque = 0;
fase_morte = 0;
fase_intro = 0;

tempo_morte = 0 * room_speed;

inv_timer = 0;

cooldown_ataque = 3.5 * room_speed; // 3.5 seg entre ataques
timer_fase      = 5 * room_speed;   // usado nos ataques por fases
penas_restantes = 0;                // só usado no ataque de penas

// ==========================
// Posições
// ==========================
pos_idle = [239.5, 168];
pos_alvo = [x, y];

// ==========================
// Limites da room
// ==========================
limite_esq = 30;
limite_dir = room_width - 30;

// ==========================
// Movimento
// ==========================
hs    = 0;
hsmax = 2;
dir   = 1;

/// ==========================
/// Função de movimento suave
/// ==========================
mover_para = function (_x, _y, _vel) {
    x = lerp(x, _x, _vel);
    y = lerp(y, _y, _vel);
    return (point_distance(x, y, _x, _y) < 2);
};

/// ==========================
/// Função de iniciar ataque
/// ==========================
ataque_boss = function() {
    if (cooldown_ataque <= 0 && _estado == "Idle") {
        var ataque_escolhido = ultimo_ataque;

        // escolhe ataque diferente do último
        while (ataque_escolhido == ultimo_ataque) {
            ataque_escolhido = irandom(array_length(padrao_ataque) - 1);
        }
        ultimo_ataque = ataque_escolhido;

        _estado = "Atacando";
        fase_ataque = 0;
        timer_fase = 0;

        var ataque_atual = padrao_ataque[ataque_escolhido];
        show_debug_message(">>> Iniciando ataque: " + ataque_atual);

        switch (ataque_atual) {
            case "Dash":
                var canto = ultimo_canto;
                while (canto == ultimo_canto) {
                    canto = irandom(3);
                }
                ultimo_canto = canto;

                switch (canto) {
                    case 0: pos_alvo = [65, 256]; canto_escolhido = "esquerda"; break;
                    case 1: pos_alvo = [65, 128]; canto_escolhido = "esquerda_cima"; break;
                    case 2: pos_alvo = [415, 128]; canto_escolhido = "direita"; break;
                    case 3: pos_alvo = [415, 256]; canto_escolhido = "direita_cima"; break;
                }

            break;

            case "Penas":
                penas_restantes = 5;
                timer_fase = room_speed * 0.5;
            break;

            case "Ataque_rapido_Player":
                if (instance_exists(oPlayer)) {
                    pos_alvo = [oPlayer.x, oPlayer.y];
                } else {
                    pos_alvo = pos_idle;
                }
            break;
        }
    }
};
