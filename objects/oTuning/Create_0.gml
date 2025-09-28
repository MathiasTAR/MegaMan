// Inherit the parent event
event_inherited();

_COLISION = layer_tilemap_get_id("tl_cenario");

padrao_ataque = ["Penas", "Penas", "Cobrir_tela"];
ultimo_ataque = -1; // Guarda o índice do último ataque
ultimo_canto = -1;  // Guarda o último canto usado (-1 = nenhum)

cooldown_ataque = 0;

_estado = "Idle";

hs = 0;
hsmax = 2;

dir = 1;

spd = 0

ataque_boss = function () {
    if (cooldown_ataque <= 0 && _estado == "Idle")
    {
        var ataque_escolhido = ultimo_ataque;
        
        // Garante que o próximo ataque seja diferente do último
        while (ataque_escolhido == ultimo_ataque) {
            ataque_escolhido = irandom(2);
        }
        
        ultimo_ataque = ataque_escolhido; // Atualiza o último ataque usado
        
        var ataque_atual = padrao_ataque[ataque_escolhido];
        _estado = "Atacando";
    
        switch (ataque_atual)
        {
            case "Penas": 
                show_debug_message(">>> " + ataque_atual);

                penas_restantes = 5;
                alarm[0] = room_speed * 2;

                break;

            case "Ataque_rapido_Player": 
                show_debug_message(">>> " + ataque_atual);
                break;
        
            case "Cobrir_tela": 
                show_debug_message(">>> " + ataque_atual);

                sprite_index = sIdleTuning;

                var canto = ultimo_canto;
                
                // Garante que o próximo canto seja diferente do último
                while (canto == ultimo_canto) {
                    canto = irandom(2);
                }
                
                ultimo_canto = canto; // Atualiza o último canto usado
                
                switch (canto) 
                {
                    case 0: 
                        show_debug_message(">>> Esquerda");
                        var pena_esquerda = instance_create_layer(80, -200, "Ataques", oPenaGrandeTuning);
                        pena_esquerda.image_xscale = 6;
                        pena_esquerda.image_yscale = 20;
                        break;
                
                    case 1: 
                        show_debug_message(">>> Meio");
                        var pena_meio = instance_create_layer(240, -200, "Ataques", oPenaGrandeTuning);
                        pena_meio.image_xscale = 6;
                        pena_meio.image_yscale = 20;
                        break;
                
                    case 2: 
                        show_debug_message(">>> Direita");
                        var pena_direita = instance_create_layer(400, -200, "Ataques", oPenaGrandeTuning);
                        pena_direita.image_xscale = 6;
                        pena_direita.image_yscale = 20;
                        break;
                }
                break;
        }
        cooldown_ataque = 190;
    }
};