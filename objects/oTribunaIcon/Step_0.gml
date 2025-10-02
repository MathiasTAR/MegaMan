var selecionado = (posicao == oSelectControler.fase_select);

if (selecionado) {
    xscale = lerp(xscale, botao_x_original * 1.1, 0.1);
	yscale = lerp(yscale, botao_y_original * 1.1, 0.1);
    image_index = 1;
} else {
    image_index = 0;
	xscale = lerp(xscale, botao_x_original * 1, 0.1);
	yscale = lerp(yscale, botao_y_original * 1, 0.1);
}

if ((keyboard_check_pressed(vk_enter) or gamepad_button_check_pressed(global.gamepad_id, gp_start))  and selecionado) {
	oSoundController.sfx_botao_selecionado.play = true;
	oSoundController.music_theme.play = true
	room_goto(Room_Tribuna);
};