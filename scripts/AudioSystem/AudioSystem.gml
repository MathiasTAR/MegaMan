	// ==============================
	// Macros
	// ==============================
	#macro au_type_sfx     "SFX"
	#macro au_type_music   "MUSIC"

	// ==============================
	// Audio Controller
	// ==============================
	function AudioController(_str_sfx, _str_music, _str_master) constructor {
	    global.__audio_controller__ = self;
    
	    global_sfx   = _str_sfx;
	    global_music = _str_music;
	    global_master= _str_master;
    
	    list_audio = ds_list_create();
    
	    vol_sfx   = 1;
	    vol_music = 1;

	    ///@method Update
	    static Update = function() {
	        self.vol_sfx   = variable_global_get(global_sfx) * variable_global_get(global_master);
	        self.vol_music = variable_global_get(global_music) * variable_global_get(global_master);
        
	        var _size = ds_list_size(list_audio);
	        for (var i = 0; i < _size; i++) {
	            list_audio[| i].Update();
	        }
	    }
	}

	// ==============================
	// Base Audio Element
	// ==============================
	function AudioElement() constructor {
	    controller = global.__audio_controller__;
	    ds_list_add(controller.list_audio, self);
    
	    play      = false;
	    sound_id  = noone;
	    type      = noone;
	    offset    = 1;
    
	    ///@method Update
	    static Update = function() { }
	}

	// ==============================
	// AudioPlaySingle (SFX) com pitch aleatório
	// ==============================
	function AudioPlaySingle(_sound_id, _au_type, _offset = 1, _pitch_min = 1, _pitch_max = 1) : AudioElement() constructor {
	    sound_id = _sound_id;
	    type     = _au_type;
	    offset   = _offset;
	    pitch_min = _pitch_min;
	    pitch_max = _pitch_max;

	    ///@method Update
	    static Update = function() {
	        if (play) {
	            var _id = audio_play_sound(sound_id, 0, false);
	            var _level;
	            if (type == au_type_sfx) {
	                _level = controller.vol_sfx * offset;
	                var _pitch = random_range(pitch_min, pitch_max);
	                audio_sound_pitch(_id, _pitch);
	            } else {
	                _level = controller.vol_music * offset;
	            }
	            audio_sound_gain(_id, _level, 0);
	            play = false;
	        }
	    }
	}

	// ==============================
	// AudioPlayLoop
	// ==============================
	function AudioPlayLoop(_sound_id, _au_type, _fade_milli = 500, _offset = 1) : AudioElement() constructor {
	    sound_id = _sound_id;
	    type     = _au_type;
	    offset   = _offset;
	    id_playind = noone;
	    vol = 0;
	    vol_spd = 1 / game_get_speed(gamespeed_fps) * (_fade_milli * 0.001);

	    ///@method Update
	    static Update = function() {
	        // Iniciar ou manter tocando
	        if (play) {
	            if (!audio_is_playing(id_playind)) {
	                id_playind = audio_play_sound(sound_id, 1, true); // loop = true
	            }
	            if (vol < 1) vol += vol_spd; else vol = 1;
	        }

	        // Parar gradualmente
	        if (!play) {
	            if (vol > 0) vol -= vol_spd;
	            if (vol <= 0) {
	                vol = 0;
	                if (audio_is_playing(id_playind)) audio_stop_sound(id_playind);
	            }
	        }

	        // Atualiza volume e pitch
	        if (audio_is_playing(id_playind)) {
	            var _level;

	            if (type == au_type_sfx) {
	                // SFX continua com pitch aleatório
	                _level = controller.vol_sfx * vol * offset;
	                var _pitch = random_range(0.9, 1.1);
	                audio_sound_pitch(id_playind, _pitch);
	            } else {
	                // Música sem pitch aleatório
	                _level = controller.vol_music * vol * offset;
	                audio_sound_pitch(id_playind, 1);
	            }

	            audio_sound_gain(id_playind, _level, 0);
	        }
	    }
	}