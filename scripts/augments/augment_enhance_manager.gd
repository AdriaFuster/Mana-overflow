extends Node

const CUSTOM_CURSOR = preload("uid://ccqwxqhu85kvl")
const HAMMER_CURSOR = preload("uid://3h5nephw47d2")


var enchance_state: bool = false

func start_enhancing() -> void:
	enchance_state = true
	Input.set_custom_mouse_cursor(HAMMER_CURSOR)
	#change mouse sprite

func disable_enhance() -> void:
	enchance_state = false
	Input.set_custom_mouse_cursor(CUSTOM_CURSOR)
	
	
func enhance_augment(a: Augment) -> void:
	a.enhance()
	disable_enhance()
	
func is_enhancing() -> bool:
	return enchance_state


func _unhandled_input(event: InputEvent) -> void:
	if enchance_state:
		if event is InputEventMouseButton and event.pressed:
			disable_enhance()
		
