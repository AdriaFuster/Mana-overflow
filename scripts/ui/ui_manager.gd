extends Control

@onready var upgrade_canvas: CanvasLayer = %UpgradeCanvas
@onready var display_click_canvas: CanvasLayer = %DisplayClickCanvas


func _ready() -> void:
	_setup()
	GameEvents.change_scene.connect(_on_change_scene)


func _setup() -> void:
	upgrade_canvas.show_upgrade_ui(true)
	display_click_canvas.show()

func _on_change_scene(scene: GlobalEnum.GAME_SCENE) -> void:
	if scene == GlobalEnum.GAME_SCENE.BOSS:
		upgrade_canvas.show_upgrade_ui(false)
		display_click_canvas.show()
		
	elif scene == GlobalEnum.GAME_SCENE.CLICK:
		upgrade_canvas.show_upgrade_ui(true)
		display_click_canvas.show()

func hide_ui() -> void:
	upgrade_canvas.hide()
	display_click_canvas.hide()
	
	
