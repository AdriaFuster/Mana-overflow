extends TextureButton
class_name CauldronAnimations

@onready var audio: AudioStreamPlayer2D = %AudioStreamPlayer2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var tween: Tween

func _ready() -> void:
	mouse_entered.connect(_button_enter)
	mouse_exited.connect(_button_exit)

func cauldron_click_anim():
	animation_player.play("click")
	_play_sound()
		
func _button_enter() -> void:
	#animation_tree.travel("hover")
	pass
	
func _button_exit() -> void:
	#animation_tree.travel("idle")
	pass

	
func _play_sound():
	var rand_pitch = randf_range(0.9, 1.1)
	audio.pitch_scale = rand_pitch
	audio.play()
	
		
