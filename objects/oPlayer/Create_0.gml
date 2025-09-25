// Create event

// 
hs = 0;
hsmax = 4;
vs = 0;
vsmax = 9;

// Gravidade e controle
no_chao = false;
grav = 0.4;

// Tempo para cada tiro
cooldown_tiro = 0;

// Colisão com OBJ
COL_OBJ = Colision;

// Inputs
_left  = noone;
_right = noone
_jump  = noone
_tiro  = noone

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

#region Idle
estado_idle.inicia = function()
{
    sprite_index = sIdle;
    image_index = 0;
    image_speed = 1;
}

estado_idle.roda = function()
{
    if (_tiro && no_chao)
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


inicia_estado(estado_idle);