// Inherit parent
event_inherited();

/// Variáveis principais
padrao_ataque = ["Cobrir_tela", "Pena", "Ataque_rapido_Player"];

ultimo_ataque = -1;
ultimo_canto = -1;

_estado = "Idle";
fase_ataque = 0;

cooldown_ataque = 5 * room_speed; // 5 seg entre ataques
timer_fase = 0 * room_speed

// Posições
pos_idle = [240, 100];
pos_alvo = [x, y];

hs = 0;
hsmax = 2;
dir = 1;

/// Função de movimento suave
mover_para = function (_x, _y, _vel) {
    x = lerp(x, _x, _vel);
    y = lerp(y, _y, _vel);
    return (point_distance(x, y, _x, _y) < 2);
};

#region Ataque
ataque_boss = function() {
    if (cooldown_ataque <= 0 && _estado == "Idle") {
		
		ataque = true
        var ataque_escolhido = ultimo_ataque;
		
        while (ataque_escolhido == ultimo_ataque) {
            ataque_escolhido = irandom(array_length(padrao_ataque) - 1);
        }
        ultimo_ataque = ataque_escolhido;

        _estado = "Atacando";
        fase_ataque = 0;

        var ataque_atual = padrao_ataque[ataque_escolhido];

        show_debug_message(">>> Iniciando ataque: " + ataque_atual);

        switch (ataque_atual) {
            case "Cobrir_tela":
                var canto = ultimo_canto;
                while (canto == ultimo_canto) {
                    canto = irandom(2);
                }
                ultimo_canto = canto;

                switch (canto) {
                    case 0: pos_alvo = [80, 105]; break;   // esquerda
                    case 1: pos_alvo = [240, 105]; break;  // meio
                    case 2: pos_alvo = [400, 105]; break;  // direita
                }
            break;

            case "Penas":
                penas_restantes = 3;
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
#endregion