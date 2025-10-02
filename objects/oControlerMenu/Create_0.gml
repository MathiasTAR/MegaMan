// Estado do menu
menu_atual = "principal";
botao_selecionado = 0;

// Arrays de botões
menu_botoes   = ["Jogar", "Opcao", "Sair"];
opcoes_botoes = ["Master", "Music", "SFX", "Controles", "Voltar"];

// Inicializa layers
layer_set_visible("ui_menu", 0);
layer_set_visible("ui_opcoes", 0);

layer_set_visible("ui_menu", 1);


// Função de ação dos botões
botao_acao = function(acao) {
    switch (acao) {
		
        case "Jogar":
            layer_set_visible("ui_menu", 0);
			layer_set_visible("ui_opcoes", 0);
            room_goto_next();
        break;

        case "Opção":
            menu_atual = "Opção";
            botao_selecionado = 0;
            layer_set_visible("ui_menu", 0);
            layer_set_visible("ui_opcoes", 1);
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
            layer_set_visible("ui_opcoes", 0);
            layer_set_visible("ui_menu", 1);
        break;
			
    }
};
