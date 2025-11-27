extends AnimationPlayer

@onready var audio: AudioStreamPlayer = $AudioStreamPlayer

func get_animation_duration(full_anim_duration: float, n_hits: int) -> float:
	var anim_lenght: float = get_animation("hurt").length
	var all_anim_lenght: float = anim_lenght * n_hits
	
	if all_anim_lenght < full_anim_duration:
		#Add seconds to each animation
		var extra_time: float = full_anim_duration - all_anim_lenght
		var single_extra_time: float = extra_time/n_hits
		return single_extra_time + anim_lenght
	elif all_anim_lenght > full_anim_duration:
		#Speed up each single animation
		var difference: float = full_anim_duration/all_anim_lenght
		return anim_lenght*difference
	else:
		return anim_lenght

func play_hit_animation(anim_duration: float) -> void:
	var anim_lenght: float = get_animation("hurt").length
	GameEvents.screen_shake.emit()
	var difference: float =  anim_duration - anim_lenght
	if difference < 0:
		var speed_multiplier: float = anim_lenght/anim_duration
		play("hurt", -1, speed_multiplier)
		await  animation_finished
		
	elif difference > 0:		
		play("hurt")
		await  animation_finished
		await get_tree().create_timer(difference).timeout
	else:
		play("hurt")
		await  animation_finished
		
func play_hit_sound() -> void:
	var rand_pitch = randf_range(0.8, 1)
	audio.pitch_scale = rand_pitch
	audio.play()
	
	
	
	
	
	
