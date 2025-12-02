extends Node

const CUSTOM_CURSOR = preload("uid://ccqwxqhu85kvl")
const HAMMER_CURSOR = preload("uid://3h5nephw47d2")


var enchance_state: bool = false

func _ready() -> void:
	GameEvents.augment_clicked.connect(_on_augment_clicked)

func enhance_augment() -> void:
	enchance_state = true
	Input.set_custom_mouse_cursor(HAMMER_CURSOR)
	#change mouse sprite

func disable_enhance() -> void:
	enchance_state = false
	Input.set_custom_mouse_cursor(CUSTOM_CURSOR)
	
	
func _on_augment_clicked(a: Augment) -> void:
	if enchance_state:
		a.enhance()
		GameEvents.augment_enhanced.emit()
		disable_enhance()
		

func _unhandled_input(event: InputEvent) -> void:
	print (event)
	if enchance_state:
		if event is InputEventMouseButton and event.pressed:
			disable_enhance()
