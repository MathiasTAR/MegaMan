//Controler de velocidade de movimento 
hs = 0;
hsmax = 4;
vs = 0;
vsmax = 9;

//Vida
_vidaPlayer = 100;

// Knockback
kb_timer = 0;
kb_force = 0;
kb_dir = 0;

// Invencibilidade
inv_timer = 0;
inv_time = 0;

// Gravidade e controle
no_chao = false;
grav = 0.45;

timer_player = 2 * room_speed

// Tempo para cada tiro
cooldown_tiro = 0;

// Inputs
_left  = noone;
_right = noone
_jump  = noone
_jump_hold = noone
_tiro  = noone

// Definição explícita de sprites por estado e poder (seguindo o padrão solicitado)
#region Sprites Idle
Idle_Default = sIdle;
Idle_Turing = sIdle_Turing;
Idle_Tribuna = sIdle_Tribuna;
#endregion

#region Sprites Walk
Walk_Default = sCorrendo;
Walk_Turing = sCorrendo_Turing;  // Assumindo que existe; ajuste se necessário
Walk_Tribuna = sCorrendo_Tribuna;
#endregion

#region Sprites Jump
Jump_Default = sPulando;
Jump_Turing = sPulando_Turing;
Jump_Tribuna = sPulando_Tribuna;
#endregion

#region Sprites Shot (Idle)
Shot_Default = sAtirando;
Shot_Turing = sAtirando_Turing;
Shot_Tribuna = sAtirando_Tribuna;
#endregion

#region Sprites Shot Walk
ShotWalk_Default = sCorrendoAtirando;
ShotWalk_Turing = sCorrendoAtirando_Turing;
ShotWalk_Tribuna = sCorrendoAtirando_Tribuna;
#endregion

#region Sprites Shot Jump
ShotJump_Default = sPulandoAtirando;
ShotJump_Turing = sPulandoAtirando_Turing;
ShotJump_Tribuna = sPulandoAtirando_Tribuna;
#endregion

#region Sprites Morto (só default)
Morto_Default = sMorto;
#endregion

function troca_poder(power_id) {
    switch (power_id) {
        case 1: 
            if (global.Turing) {
                global.current_power = 1;
                show_debug_message("Poder Turing ativado!");
            } else {
                show_debug_message("Poder Turing não desbloqueado!");
            }
            break;
        case 2: 
            if (global.Tribuna) {
                global.current_power = 2;
                show_debug_message("Poder Tribuna ativado!");
            } else {
                show_debug_message("Poder Tribuna não desbloqueado!");
            }
            break;
        default: 
            global.current_power = 0;
            show_debug_message("Poder Default ativado!");
            break;
    }
}

#region Iniciar Estados
// Iniciando o estado Idle
estado_idle = new estado();
// Iniciando estado Walk
estado_walk = new estado();
// Iniciando estado Jump
estado_jump = new estado();
// Iniciando estado Shot
estado_shot = new estado();
// Iniciando estado Shot Walk
estado_shotwalk = new estado();
// Iniciando estado Shot Jump
estado_shotjump = new estado();
// Iniciando estado Sofrendo dano
estado_dano = new estado();
// Iniciando estado Morto
estado_morto = new estado();
#endregion

#region Idle
estado_idle.inicia = function()
{
    // Troca de sprite baseada no poder atual
    switch (global.current_power) {
        case 1:
            if (global.Turing) {
                sprite_index = Idle_Turing;
            } else {
                sprite_index = Idle_Default;
            }
            break;
        case 2:
            if (global.Tribuna) {
                sprite_index = Idle_Tribuna;
            } else {
                sprite_index = Idle_Default;
            }
            break;
        default:
            sprite_index = Idle_Default;
            break;
    }
    image_index = 0;
    image_speed = 1;
}

estado_idle.roda = function()
{
	if (_vidaPlayer <= 0) {
        troca_estado(estado_morto);
    }
    else if (_tiro && no_chao)
    {
        troca_estado(estado_shot);
    }
    else if (!no_chao)
    {
        troca_estado(estado_jump);
    }
    else if (_left xor _right)
    {
        troca_estado(estado_walk);
    }
}
#endregion

#region Walk
estado_walk.inicia = function()
{
    // Troca de sprite baseada no poder atual
    switch (global.current_power) {
        case 1:
            if (global.Turing) {
                sprite_index = Walk_Turing;
            } else {
                sprite_index = Walk_Default;
            }
            break;
        case 2:
            if (global.Tribuna) {
                sprite_index = Walk_Tribuna;
            } else {
                sprite_index = Walk_Default;
            }
            break;
        default:
            sprite_index = Walk_Default;
            break;
    }
    image_index = 0;
    image_speed = 1;
}

estado_walk.roda = function()
{
    // Se atirando → estado shot walk
    if (_tiro && no_chao)
    {
        troca_estado(estado_shotwalk);
    }
    else if (!no_chao)
    {
        troca_estado(estado_jump);
    }
    else if (!(_right xor _left))
    {
        troca_estado(estado_idle);
    }
}
#endregion

#region Jump
estado_jump.inicia = function()
{
    // Troca de sprite baseada no poder atual
    switch (global.current_power) {
        case 1:
            if (global.Turing) {
                sprite_index = Jump_Turing;
            } else {
                sprite_index = Jump_Default;
            }
            break;
        case 2:
            if (global.Tribuna) {
                sprite_index = Jump_Tribuna;
            } else {
                sprite_index = Jump_Default;
            }
            break;
        default:
            sprite_index = Jump_Default;
            break;
    }
    image_index = 0;
    image_speed = 1;
}

estado_jump.roda = function()
{
    // Se atirando → estado shot jump
    if (_tiro)
    {
        troca_estado(estado_shotjump);
    }

    if (image_index >= image_number - 1)
    {
        image_index = image_number - 1;
        image_speed = 0;
    }

    if (no_chao)
    {
        if (_left xor _right)
            troca_estado(estado_walk);
        else
            troca_estado(estado_idle);
    }
}
#endregion

#region Shot Idle
estado_shot.inicia = function()
{
    // Troca de sprite baseada no poder atual
    switch (global.current_power) {
        case 1:
            if (global.Turing) {
                sprite_index = Shot_Turing;
            } else {
                sprite_index = Shot_Default;
            }
            break;
        case 2:
            if (global.Tribuna) {
                sprite_index = Shot_Tribuna;
            } else {
                sprite_index = Shot_Default;
            }
            break;
        default:
            sprite_index = Shot_Default;
            break;
    }
    image_index = 0;
    image_speed = 1;
}

estado_shot.roda = function()
{
    if (image_index >= image_number - 1)
    {
        if (_left xor _right)
            troca_estado(estado_walk);
        else
            troca_estado(estado_idle);
    }
}
#endregion

#region Shot Walk
estado_shotwalk.inicia = function()
{
    // Troca de sprite baseada no poder atual
    switch (global.current_power) {
        case 1:
            if (global.Turing) {
                sprite_index = ShotWalk_Turing;
            } else {
                sprite_index = ShotWalk_Default;
            }
            break;
        case 2:
            if (global.Tribuna) {
                sprite_index = ShotWalk_Tribuna;
            } else {
                sprite_index = ShotWalk_Default;
            }
            break;
        default:
            sprite_index = ShotWalk_Default;
            break;
    }
    image_index = 0;
    image_speed = 1;
}

estado_shotwalk.roda = function()
{
    if (image_index >= image_number - 1)
    {
        if (!(_left xor _right))
            troca_estado(estado_idle);
        else
            troca_estado(estado_walk);
    }

    if (!no_chao)
        troca_estado(estado_shotjump);
}
#endregion

#region Shot Jump
estado_shotjump.inicia = function()
{
    // Troca de sprite baseada no poder atual
    switch (global.current_power) {
        case 1:
            if (global.Turing) {
                sprite_index = ShotJump_Turing;
            } else {
                sprite_index = ShotJump_Default;
            }
            break;
        case 2:
            if (global.Tribuna) {
                sprite_index = ShotJump_Tribuna;
            } else {
                sprite_index = ShotJump_Default;
            }
            break;
        default:
            sprite_index = ShotJump_Default;
            break;
    }
    image_index = 0;
    image_speed = 1;
}

estado_shotjump.roda = function()
{
    if (image_index >= image_number - 1)
    {
        image_index = image_number - 1;
        image_speed = 0;
    }

    if (no_chao)
    {
        if (_left xor _right)
            troca_estado(estado_shotwalk);
        else
            troca_estado(estado_shot);
    }
}
#endregion

#region Dano
estado_dano.inicia = function()
{
    // Usa variante de Jump para dano (troca baseada no poder atual)
    switch (global.current_power) {
        case 1:
            if (global.Turing) {
                sprite_index = Jump_Turing;
            } else {
                sprite_index = Jump_Default;
            }
            break;
        case 2:
            if (global.Tribuna) {
                sprite_index = Jump_Tribuna;
            } else {
                sprite_index = Jump_Default;
            }
            break;
        default:
            sprite_index = Jump_Default;
            break;
    }
    image_index = 0;
    image_speed = 1;

    if (image_index >= image_number - 1)
    {
        image_index = image_number - 1;
        image_speed = 0;
        oSoundController.sfx_dano.play = true;
    
        // define KB fixo estilo MegaMan
        if (image_xscale > 0) {
            kb_dir = 180; // empurra p/ esquerda
        } else {
            kb_dir = 0;   // empurra p/ direita
        }
    
        kb_timer = 0.1 * room_speed;
        kb_force = 1;

        // ativa invencibilidade
        inv_timer = 1.5 * room_speed;
    }
}

estado_dano.roda = function()
{
    if (_vidaPlayer <= 0) {
        troca_estado(estado_morto);
        _vidaPlayer = 0
    }

    if (kb_timer <= 0) {
        if (no_chao) {
            if (_left xor _right)
                troca_estado(estado_walk);
            else
                troca_estado(estado_idle);
        } else {
            troca_estado(estado_jump);
        }
    }
}
#endregion

#region Morto
estado_morto.inicia = function()
{
    sprite_index = Morto_Default; // Só default
    image_index = 0;
    image_speed = 1;
    timer_player = 3 * room_speed
}

estado_morto.roda = function()
{
    if (image_index >= image_number - 1) {
        image_index = image_number - 1;
        image_speed = 0;
    };
}
#endregion

inicia_estado(estado_idle);