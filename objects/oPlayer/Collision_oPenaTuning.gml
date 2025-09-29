if (inv_timer <= 0 and estado_atual != estado_morto){
	instance_destroy(other)
	Dano_KB(3)
	troca_estado(estado_dano);
};