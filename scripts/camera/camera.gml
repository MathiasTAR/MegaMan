function cameraInit() {
    // Resolução base do jogo (pixel perfect)
    global.cameraWidth  = 480;
    global.cameraHeight = 270;

    // Detecta a resolução do monitor
    var monW = display_get_width();
    var monH = display_get_height();

    // Calcula o maior scale inteiro que cabe na tela
    var scaleW = floor(monW / global.cameraWidth);
    var scaleH = floor(monH / global.cameraHeight);

    global.windowScale = min(scaleW, scaleH);

    // Garante que nunca seja menor que 1
    if (global.windowScale < 1) global.windowScale = 1;

    // Aplica a escala no tamanho da janela
    window_set_size(global.cameraWidth * global.windowScale, global.cameraHeight * global.windowScale);

    // Força a surface principal a ter o tamanho da câmera
    surface_resize(application_surface, global.cameraWidth, global.cameraHeight);

    // GUI segue a mesma resolução da câmera
    display_set_gui_size(global.cameraWidth, global.cameraHeight);

    // Centraliza a janela
    window_center();

    // Configura a câmera
    camera_set_view_size(view_camera[0], global.cameraWidth, global.cameraHeight);
    view_enabled     = true;
    view_visible[0]  = true;
}

function cameraUPD() {
    var _cameraX = camera_get_view_x(view_camera[0]);
    var _cameraY = camera_get_view_y(view_camera[0]);

	if (instance_exists(oPlayer)){
	    var _targetX = oPlayer.x - (global.cameraWidth * 0.5);
	    var _targetY = oPlayer.y - (global.cameraHeight * 0.5);

	    // Limites
	    _targetX = clamp(_targetX, 0, room_width  - global.cameraWidth);
	    _targetY = clamp(_targetY, 0, room_height - global.cameraHeight);

	    // Suavização (0.2 = velocidade do "follow")
	    var _newX = lerp(_cameraX, _targetX, 0.2);
	    var _newY = lerp(_cameraY, _targetY, 0.2);

	    // Travar em inteiros → evita borrão nos pixels
	    _newX = floor(_newX);
	    _newY = floor(_newY);

	    camera_set_view_pos(view_camera[0], _newX, _newY);
	}
}
