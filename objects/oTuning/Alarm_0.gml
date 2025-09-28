if (penas_restantes > 0) {
	var pena_meio = instance_create_layer(x, y, "Ataques", oPenaTuning);
	pena_meio.dir = point_direction(x, y, oPlayer.x, oPlayer.y); // reta pro player

	var pena_esq = instance_create_layer(x, y, "Ataques", oPenaTuning);
	pena_esq.dir = point_direction(x, y, oPlayer.x, oPlayer.y) - 20; // diagonal esquerda

	var pena_dir = instance_create_layer(x, y, "Ataques", oPenaTuning);
	pena_dir.dir = point_direction(x, y, oPlayer.x, oPlayer.y) + 20; // diagonal direita

	penas_restantes--; // menos uma pena pra soltar

	// se ainda tem, agenda o próximo disparo
	if (penas_restantes > 0) {
		alarm[0] = room_speed * 2 // mais 1 segundo
	}
}
