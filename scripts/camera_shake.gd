extends CanvasLayer

var shake_intensity: float = 0.0
var shake_timer: float = 0.0
var original_offset := Vector2.ZERO
var shake_lenght: Vector2

func _ready() -> void:
	original_offset = offset
	GameEvents.screen_shake.connect(_on_screen_shake)

func _on_screen_shake(intensity: float = 8, duration: float = 0.1) -> void:
	print("shake")
	shake_intensity = intensity
	shake_timer = duration
	shake_lenght = 	Vector2(1,1)
func _process(delta: float) -> void:
	if shake_timer > 0:
		shake_timer -= delta
		offset = original_offset + Vector2(
			randf_range(-shake_lenght.x, shake_lenght.x),
			randf_range(-shake_lenght.y, shake_lenght.y)
		) * shake_intensity
		shake_intensity = lerp(shake_intensity, 0.0, delta * 10)
	else:
		offset = original_offset
