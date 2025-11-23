extends Control
class_name BaseScene


func _ready() -> void:
	GameEvents.change_scene.connect(_on_change_scene)
	_setup()
	
	
func _setup() -> void:
	pass
	
	
func _on_change_scene(scene: GlobalEnum.GAME_SCENE) -> void:
	if scene == GlobalEnum.GAME_SCENE.BOSS:
		_on_boss_scene()
		
	elif scene == GlobalEnum.GAME_SCENE.CLICK:
		_on_click_scene()

func _on_boss_scene() -> void:
	pass
	
func _on_click_scene() -> void:
	pass
