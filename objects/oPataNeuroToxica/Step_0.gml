// Atualiza timers
if (timerL > 0) timerL--;
if (timerR > 0) timerR--;
if (inv_timer > 0) inv_timer--;

// ==============================
// Lado Esquerdo
// ==============================
if (LadoPata == "Esquerda" && vidaPata_Esquerda > 0 && timerL <= 0) {

    // Executa animação de ataque
    image_speed = 1;

    if (image_index >= image_number - 1) {
        // Fim da animação → pausa
        image_index  = image_number - 1;
        image_speed  = 0;
        x            = 78;
        y            = 1567;
        image_angle  = -40;
		oColisaoPlayer1.x = -24
		colisao_ativa = true;
    }
}

    // Retorna à posição inicial após o tempo
if (vidaPata_Esquerda <= 0) {
	oColisaoPlayer1.x = -100
	colisao_ativa = false;
	image_index  = 0;
	x            = 95;
	y            = 1510;
	image_angle  = 0;
	vidaPata_Esquerda = 15
	timerL       = 6 * room_speed; // Espera
	vidaPata_Esquerda = clamp(vidaPata_Esquerda, 0, 15);
}
	

// ==============================
// Lado Direito
// ==============================
if (LadoPata == "Direita" && vidaPata_Direita > 0 && timerR <= 0) {

    image_speed = 1;

    if (image_index >= image_number - 1) {
        image_index  = image_number - 1;
        image_speed  = 0;
        x            = 405;
        y            = 1567;
        image_angle  = 40;
		oColisaoPlayer2.x = 440
		colisao_ativa = true;
    }
}

if (vidaPata_Direita <= 0) {
	oColisaoPlayer2.x = 600
	colisao_ativa = false;
	image_index  = 0;
	x            = 385;
	y            = 1510;
	image_angle  = 0;
	vidaPata_Direita = 15
	timerR       = 6 * room_speed;
	vidaPata_Direita = clamp(vidaPata_Direita, 0, 15);
    
}

if (inv_timer > 0) {
    if (inv_timer div 4 mod 6) image_blend = c_grey;
    else image_blend = c_white;
} else {
    image_blend = c_white;
}