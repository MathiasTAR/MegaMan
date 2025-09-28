// Inherit the parent event
event_inherited();

_COLISION = layer_tilemap_get_id("tl_cenario");

hs = hsmax * dir;

if (hs != 0) image_xscale = sign(hs);

move_and_collide(hs, 0, _COLISION, 12);

if (x <= 35){
	dir = 1;
}
else if (x >= 445){
	dir = -1;
};

if (hs != 0) {
	sprite_index = sVoandoIdleTuning;
}else{
	sprite_index = sIdleTuning;
}

// Teste manual: CTRL força ataque
if keyboard_check_pressed(vk_control) {
	ataque_boss();
}

// Timers e controle de estado
if (cooldown_ataque >= 0) {
	cooldown_ataque--;
	// continua em "Atacando" até cooldown acabar
	if (cooldown_ataque <= 0) {
		_estado = "Idle";
		y = 55;
	}
}
