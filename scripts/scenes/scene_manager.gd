extends Node

@onready var game_scene: ClickScene = %Game
@onready var boss_scene: BossScene = %Boss
@onready var test_scene: Button = $"../UI/TestScene"
@onready var boss_test_scene: Control = %BossTestScene


func _ready() -> void:
	GameEvents.change_scene.connect(_on_change_scene)
	boss_scene.desactivate_scene()
	game_scene.activate_scene()
	test_scene.pressed.connect(_on_test_scene)


func _on_change_scene(scene: GlobalEnum.GAME_SCENE) -> void:
	if scene == GlobalEnum.GAME_SCENE.BOSS:
		boss_scene.activate_scene()
		game_scene.desactivate_scene()
		
	elif scene == GlobalEnum.GAME_SCENE.CLICK:
		boss_scene.desactivate_scene()
		game_scene.activate_scene()
	

func _on_test_scene() -> void:
	boss_scene.desactivate_scene()
	game_scene.desactivate_scene()
	boss_test_scene.show()
	%InventoryUI.hide_ui()
