// Inherit the parent event
event_inherited();

// Libera o poder Turing ao colidir com o player
if (instance_exists(oPlayer)) {
	oPlayer.troca_poder(1);
    y = 500;
}