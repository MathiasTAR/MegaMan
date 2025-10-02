if (instance_exists(oTribuna)) {
	if (inv_timer <= 0 and estado_atual != estado_morto and oTribuna._estado != "Morto"){
		Dano_KB(15)
		troca_estado(estado_dano);
	}
};