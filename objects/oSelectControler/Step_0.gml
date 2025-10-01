if (keyboard_check_pressed(vk_down) or gamepad_button_check_pressed(global.gamepad_id, gp_padd)){
	fase_select++;
	oSoundController.sfx_botao.play = true
	if (fase_select >= 4) {fase_select = 0};
};