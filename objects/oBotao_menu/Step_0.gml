// Pega referência do controller
var controler = oControlerMenu;

// Suaviza o tamanho do botão
xscale = lerp(xscale, botao_x_original, 0.09);
yscale = lerp(yscale, botao_y_original, 0.09);

// Verifica se este botão é o selecionado
var selecionado = (posicao == controler.botao_selecionado);


if (selecionado) {
    xscale = lerp(xscale, botao_x_original * 1.3, 0.1);
    image_index = 1;
} else {
    image_index = 0;
	
}

// Executa ação ao pressionar Enter
if (selecionado && keyboard_check_pressed(vk_enter)) {
    controler.botao_acao(acao);
}
