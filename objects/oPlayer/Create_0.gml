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
_tiro  = noone


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
    sprite_index = sIdle;
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
    sprite_index = sCorrendo;
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
    sprite_index = sPulando;
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
    sprite_index = sAtirando;
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
    sprite_index = sCorrendoAtirando;
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
    sprite_index = sPulandoAtirando;
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
    sprite_index = sPulando;
    image_index = 0;
    image_speed = 1;

	
	 if (image_index >= image_number - 1)
	 {
        image_index = image_number - 1;
        image_speed = 0;
		oSoundController.sfx_dano.play = true
	
    // define KB fixo estilo MegaMan
    if (image_xscale > 0) {
        kb_dir = 180; // empurra p/ esquerda
    } else {
        kb_dir = 0;   // empurra p/ direita
    }

	
    kb_timer = 0.1 * room_speed;
    kb_force = 2;

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
    sprite_index = sMorto;
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