/// ==========================
/// VARIÁVEIS PRINCIPAIS
/// ==========================
padrao_ataque = ["Veneno", "Veneno"]; // lista de ataques possíveis

_vidaBoss = 150;

// Controle de ataques e estados
ultimo_ataque  = -1;
ultimo_veneno_X = -1;
_estado        = "Intro";
fase_intro     = 0;
fase_ataque    = 0;
fase_morte     = 0;

// Armazena os venenos criados
venenos_ativos = [];
veneno_index = 0;
qtn_veneno = 0;
delay_veneno = 0;
tempo_veneno = 0;


// Timers e flags
tempo_proximo = 0

tempo_morte    = 0;
inv_timer      = 0;
vuneravel      = true;
cooldown_ataque = 1.5 * room_speed;
timer_fase     = 0;

// ==========================
// POSIÇÕES
// ==========================
pos_idle = [240, 180];
pos_alvo = [x, y];

// ==========================
// LIMITES DA ROOM
// ==========================
limite_esq = 30;
limite_dir = room_width - 30;

// ==========================
// MOVIMENTO
// ==========================
hs     = 0;
hsmax  = 2;
dir    = 1;


/// ==========================
/// FUNÇÃO DE MOVIMENTO SUAVE
/// ==========================
/// move o boss até o ponto com velocidade proporcional (_vel = 0.1 a 1)
mover_para = function(_x, _y, _vel) {
    x = lerp(x, _x, _vel);
    y = lerp(y, _y, _vel);
    return (point_distance(x, y, _x, _y) < 2);
};


/// ==========================
/// FUNÇÃO DE INICIAR ATAQUE
/// ==========================
/// Seleciona e inicia o próximo ataque do boss
ataque_boss = function() {
    if (cooldown_ataque <= 0 && _estado == "Idle") {
        var ataque_escolhido = ultimo_ataque;

        // Escolhe um ataque diferente do último
        while (ataque_escolhido == ultimo_ataque) {
            ataque_escolhido = irandom(array_length(padrao_ataque) - 1);
        }

        ultimo_ataque = ataque_escolhido;

        // Troca para o estado de ataque
        _estado = "Atacando";
        fase_ataque = 0;
        timer_fase = 0;

        var ataque_atual = padrao_ataque[ataque_escolhido];
        show_debug_message("Iniciando ataque: " + string(ataque_atual));

        // Aqui, você poderia definir animações específicas por tipo de ataque
        switch (ataque_atual) {
            case "Veneno":
                // Define sprite inicial ou som de ataque, se quiser
                // exemplo: sprite_index = sBossAtaqueVeneno;
            break;
        }
    }
};
