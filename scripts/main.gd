extends Node2D

@onready var game: Control = %Game
@onready var boss: Control = %Boss



func _ready() -> void:
	GameEvents.change_scene.connect(_on_change_scene)
	_setup()
	
	
func _setup() -> void:
	boss.hide()
	game.show()
	

			
func _on_change_scene(scene: GlobalEnum.GAME_SCENE) -> void:
	if scene == GlobalEnum.GAME_SCENE.BOSS:
		boss.show()
		game.hide()
	elif scene == GlobalEnum.GAME_SCENE.BASE:
		boss.hide()
		game.show()
