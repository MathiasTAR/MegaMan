if (instance_exists(oVenenoChaoNeuroToxica)){
	if (inv_timer <= 0 and estado_atual != estado_morto){
		switch (oVenenoChaoNeuroToxica.FaseVenenoChao){
			case 0:
				Dano_KB(100);
				troca_estado(estado_dano);
			break;
			
			case 1:
				Dano_KB(15);
				troca_estado(estado_dano);
				x = room_width/2;
				y = 1680;
			break;
		}
	};
}