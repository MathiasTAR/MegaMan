if (timer > 0) {timer--}

if (timer <= 0 && coletado){
	room_goto(Menu)
	
	layer_set_visible("ui_menu", 0);
		
	layer_set_visible("ui_opcoes", 0);

	layer_set_visible("ui_menu", 1);
}

show_debug_message(timer)