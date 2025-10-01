draw_sprite_ext(sprite_index, image_index, x, y, xscale, yscale, image_angle, image_blend, image_alpha);

// Agora configure fonte, cor, alinhamento, etc:
draw_set_font(Botao);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(c_white);


for (var i = 0; i < 3; i++){
	draw_text(x, y-1, acao);
}