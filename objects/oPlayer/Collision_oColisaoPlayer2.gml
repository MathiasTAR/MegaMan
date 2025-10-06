if (instance_exists(oColisaoPlayer2)) {
	if (inv_timer <= 0 and estado_atual != estado_morto){
		Dano_KB(15)
		troca_estado(estado_dano);
	}
};