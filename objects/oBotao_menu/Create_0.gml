cameraInit()

layer_set_visible("ui_opcoes", 0)

botao_x_original = image_xscale;

botao_y_original = image_yscale;

xscale = botao_x_original;

yscale = botao_y_original;


botao_acao = function()
{
	switch(acao)
	{
		case "Jogar": 
			layer_set_visible("ui_menu", 0)
			room_goto_next()
			break;
		
		case "Opcao": 
			layer_set_visible("ui_menu", 0)
			layer_set_visible("ui_opcoes", 1)
			break;
		
		case "Sair":
			show_debug_message("Sair")
			break;
			
		case "Voltar":
			layer_set_visible("ui_opcoes", 0)
			layer_set_visible("ui_menu", 1)
			break;
	
	}
}

