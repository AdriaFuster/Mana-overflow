extends Control

@onready var items: ItemsUIManager = %Items
@onready var display_click_canvas: CanvasLayer = %DisplayClickCanvas
@onready var display_boss_canvas: CanvasLayer = %DisplayBossCanvas


func _ready() -> void:
	_setup()
	GameEvents.change_scene.connect(_on_change_scene)


func _setup() -> void:
	items.show_upgrade_ui(true)
	display_click_canvas.show()
	display_boss_canvas.hide()

func _on_change_scene(scene: GlobalEnum.GAME_SCENE) -> void:
	if scene == GlobalEnum.GAME_SCENE.BOSS:
		items.show_upgrade_ui(false)
		display_click_canvas.hide()
		display_boss_canvas.show()
	elif scene == GlobalEnum.GAME_SCENE.CLICK:
		items.show_upgrade_ui(true)
		display_click_canvas.show()
		display_boss_canvas.hide()
	
	
	
