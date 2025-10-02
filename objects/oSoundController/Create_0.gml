// Create oSoundController
global.VOL_SFX = 0;
global.VOL_MUSIC = 0;
global.VOL_MASTER = 0;

audio_controller = new AudioController("VOL_SFX", "VOL_MUSIC", "VOL_MASTER");

sfx_botao = new AudioPlaySingle(snd_blipSelect, au_type_sfx, 1);

sfx_botao_selecionado = new AudioPlaySingle(snd_blipSelect, au_type_sfx, 1, 1.5);

sfx_tiro = new AudioPlaySingle(snd_laserShoot, au_type_sfx, 0.8, 0.8, 1.2); 

sfx_dano = new AudioPlaySingle(snd_hitHurt, au_type_sfx, 1, 0.9, 1.1);

sfx_jump = new AudioPlaySingle(sndjump, au_type_sfx, 0.6, 0.7, 1.3);

music_theme = new AudioPlayLoop(sndmusic_teste, au_type_music, 2000, 1);
