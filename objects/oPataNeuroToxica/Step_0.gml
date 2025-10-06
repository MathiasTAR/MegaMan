if (keyboard_check_pressed(ord("O"))){
	tempo_bloqueio --;
}

if (keyboard_check_pressed(ord("P"))){
	tempo_bloqueio ++;
}

if (tempo_bloqueio < 0){
	if (LadoPata == "Esquerda"){
		image_speed = 1
		if (image_index >= image_number - 1) {
			image_index = image_number - 1;
			image_speed = 0;
			x = 87;
			y = 1043;
			image_angle = -35;
		}
	}
	
	if (LadoPata == "Direita"){
		image_speed = 1
		if (image_index >= image_number - 1) {
			image_index = image_number - 1;
			image_speed = 0;
			x = 400;
			y = 1043;
			image_angle = 35
		}
	}
} else {
	if (LadoPata == "Esquerda"){
		image_index = 0;
		x = 87.5;
		y = 1035;
		image_angle = 0;
	}
	
	if (LadoPata == "Direita"){
		image_index = 0;
		x = 388;
		y = 1036;
		image_angle = 0;
	}
	
}