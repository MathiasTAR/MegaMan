oSoundController.music_theme.play = true

// Estado do menu
menu_atual = "principal";
botao_selecionado = 0;

// Arrays de botões
menu_botoes   = ["Jogar", "Opcao", "Sair"];
opcoes_botoes = ["Master", "Music", "SFX", "Controles", "Voltar"];


// Função de ação dos botões
botao_acao = function(acao) {
    switch (acao) {
		
        case "Jogar":
            room_goto(Select_Fase);
        break;

        case "Opção":
            menu_atual = "Opção";
            botao_selecionado = 0;
			room_goto(Opcao);
        break;

        case "Sair":
            game_end();
        break;

		case "Controles":
			show_debug_message("Dead Zone")
			
		break;
		

        case "Voltar":
            menu_atual = "principal";
            botao_selecionado = 0;
			room_goto(Menu)
        break;
			
    }
};