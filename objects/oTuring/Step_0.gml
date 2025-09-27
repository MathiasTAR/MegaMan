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

if (keyboard_check_pressed(vk_enter) and selecionado) {room_goto(5)};