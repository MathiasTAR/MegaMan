var controler = oControlerMenu;

var selecionado = (posicao == controler.botao_selecionado);

// Detecta input de esquerda/direita
var _dir = 0;

if (keyboard_check_pressed(vk_right) or gamepad_button_check_pressed(global.gamepad_id, gp_padr)) _dir = 1;
if (keyboard_check_pressed(vk_left)  or gamepad_button_check_pressed(global.gamepad_id, gp_padl)) _dir = -1;

// Animação e sprite
if (selecionado) {
    image_blend = c_orange
} else {
    image_blend = c_white
}


// Aplica se selecionado e houve input
if (selecionado && _dir != 0) {
	var min_frame = 0;
	var max_frame = 10;
	var frame_atual = clamp(image_index - _dir, min_frame, max_frame);

	if (frame_atual != image_index) {
		oSoundController.sfx_botao_selecionado.play = true;
		image_index = frame_atual
		switch (acao){
			case "Volume Master":
				if (_dir >= 1){global.VOL_MASTER = clamp(global.VOL_MASTER + _vol_step, 0, 1)}
				else{global.VOL_MASTER = clamp(global.VOL_MASTER - _vol_step, 0, 1)};
			break;
				
			case "Volume Música":
				if (_dir >= 1){global.VOL_MUSIC = clamp(global.VOL_MUSIC + _vol_step, 0, 1)}
				else{global.VOL_MUSIC = clamp(global.VOL_MUSIC - _vol_step, 0, 1)};
			break;
			
			case "Volume SFX":
				if (_dir >= 1){global.VOL_SFX = clamp(global.VOL_SFX + _vol_step, 0, 1)}
				else{global.VOL_SFX = clamp(global.VOL_SFX - _vol_step, 0, 1)};
			break;
			
		}
	}
	
}

show_debug_message(global.VOL_MASTER)

// Guarda estado para o próximo step
selecionando_antes = selecionado;
