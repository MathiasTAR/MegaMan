if (instance_exists(oTuring)) {
	if (inv_timer <= 0 and estado_atual != estado_morto and oTuring._estado != "Morto"){
		Dano_KB(15)
		troca_estado(estado_dano);
	}
};