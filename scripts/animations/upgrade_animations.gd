extends TextureButton
class_name UpgradeAnimations

@onready var audio: AudioStreamPlayer2D = %AudioStreamPlayer2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var tween: Tween

func _ready() -> void:
	pressed.connect(_on_pressed)

func _on_pressed():
	animation_player.play("click")
	#_play_sound()
		

	
func _play_sound():
	var rand_pitch = randf_range(0.9, 1.1)
	audio.pitch_scale = rand_pitch
	audio.play()
	
		
