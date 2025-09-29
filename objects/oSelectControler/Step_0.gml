if (keyboard_check_pressed(vk_down)){
	fase_select++;
	oSoundController.sfx_botao.play = true
	if (fase_select >= 4) {fase_select = 0};
};