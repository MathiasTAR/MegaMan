if (!colisao_ativa) exit;

if (LadoPata == "Esquerda") {
    vidaPata_Esquerda --;
	inv_timer = 10;
	instance_destroy(other);
}else{inv_timer --}

if (LadoPata == "Direita") {
    vidaPata_Direita --;
	inv_timer = 10;
	instance_destroy(other);
}else{inv_timer --}
