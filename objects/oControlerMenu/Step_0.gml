// Controles de seleção
if (keyboard_check_pressed(vk_down) || gamepad_button_check_pressed(global.gamepad_id, gp_padd)) {
    botao_selecionado++;
}
else if (keyboard_check_pressed(vk_up) || gamepad_button_check_pressed(global.gamepad_id, gp_padu)) {
    botao_selecionado--;
}

// Pega o array de botões do menu atual
var botoes_atuais;
if (menu_atual == "principal") {
    botoes_atuais = menu_botoes;
}
else {
    botoes_atuais = opcoes_botoes;
}

// Mantém dentro do limite
if (botao_selecionado >= array_length(botoes_atuais)) {
    botao_selecionado = 0;
}
if (botao_selecionado < 0) {
    botao_selecionado = array_length(botoes_atuais) - 1;
}
