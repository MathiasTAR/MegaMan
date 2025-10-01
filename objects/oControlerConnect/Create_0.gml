global.gamepad_id = noone;
global.gamepad_deadzone = 0.5

gamepad_connect = function(){
	var _gamepad_slot = gamepad_get_device_count();
	
	for (var i = 0; i < _gamepad_slot; i++){
		if (gamepad_is_connected(i)) {
			global.gamepad_id = i;
			return true;
		}
	}
	return false;
};
