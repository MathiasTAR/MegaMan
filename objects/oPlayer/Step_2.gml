switch (estado) {
    case Estado.Idle:     sprite_index = sIdle; break;
    case Estado.Correndo: sprite_index = sCorrendo; break;
    case Estado.Pulando:  sprite_index = sPulando; break;
    case Estado.Atirando: sprite_index = sAtirando; break;
	case Estado.CorrendoAtirando: sprite_index = sCorrendoAtirando; break;
	case Estado.PulandoAtirando: sprite_index = sCorrendoAtirando; break;
}
