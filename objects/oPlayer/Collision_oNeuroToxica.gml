if (instance_exists(oNeuroToxica)) {
	if (inv_timer <= 0 and estado_atual != estado_morto){
		Dano_KB(15)
		troca_estado(estado_dano);
	}
};