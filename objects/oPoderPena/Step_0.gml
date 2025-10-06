if (y < 180){
	y++;
}

if (_pena){
	if (_timer > 0){_timer--}
	else {
		room_goto(Menu); 
		
		layer_set_visible("ui_menu", 0);
		
		layer_set_visible("ui_opcoes", 0);

		layer_set_visible("ui_menu", 1);
		}
}
		