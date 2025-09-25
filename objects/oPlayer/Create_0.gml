hs = 4; // velocidade horizontal
vs = 0; // velocidade vertical
no_chao = false;
cooldown_tiro = 0;

estado = Estado.Idle;
COL_OBJ = Colision;


enum Estado {
	Idle,
    Correndo,
    Pulando,
    Atirando,
	CorrendoAtirando,
	PulandoAtirando,
};