// Pega referência do controller
var controler = oControlerMenu;

// Suaviza o tamanho do botão
xscale = lerp(xscale, botao_x_original, 0.09);
yscale = lerp(yscale, botao_y_original, 0.09);

// Verifica se este botão é o selecionado
var selecionado = (posicao == controler.botao_selecionado);

// Detecta transição (quando passa a ser selecionado)
if (selecionado && !was_selected) {
    oSoundController.sfx_botao.play = true;
}

// Animação e sprite
if (selecionado) {
    xscale = lerp(xscale, botao_x_original * 1.3, 0.1);
    image_index = 1;
} else {
    image_index = 0;
}


// Executa ação ao pressionar Enter
if (keyboard_check_pressed(vk_enter) or gamepad_button_check_pressed(global.gamepad_id, gp_start)) and selecionado {
    controler.botao_acao(acao);
}

// Guarda estado para o próximo step
was_selected = selecionado;
