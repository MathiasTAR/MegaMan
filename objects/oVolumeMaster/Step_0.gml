// Pega referência do controller
var menu_controller = oControlerMenu;

// Verifica se este botão é o selecionado
var selecionado = (posicao == menu_controller.botao_selecionado);

// Detecta transição (quando passa a ser selecionado)
if (selecionado && !selecionando_antes) {
    oSoundController.sfx_botao.play = true;
}

// Detecta input de esquerda/direita
var delta = 0;
if (keyboard_check_pressed(vk_right) or gamepad_button_check_pressed(global.gamepad_id, gp_padr)) delta = 1;
if (keyboard_check_pressed(vk_left)  or gamepad_button_check_pressed(global.gamepad_id, gp_padl)) delta = -1;

// Aplica se selecionado e houve input
if (selecionado && delta != 0) {
	for (var i = 0; i < posicao; i++){
		var min_frame = 0;
	    var max_frame = 10;
	    var new_index = clamp(image_index + delta, min_frame, max_frame);

	    if (new_index != image_index) {
	        oSoundController.sfx_botao_selecionado.play = true;
		}
	}
}

// Guarda estado para o próximo step
selecionando_antes = selecionado;
