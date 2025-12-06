extends Node

@export var node: Control
@export var popup_type: GlobalEnum.POPUP_TYPE
@export var distribution_mode: GlobalEnum.DISTRIBUTION_MODE

func _ready() -> void:
	node.mouse_entered.connect(_on_mouse_entered)
	node.mouse_exited.connect(_on_mouse_exited)

func _show_popup() -> void:
	var item = null
	if node.has_method("get_item"):
		item = node.get_item()
	PopupManager.show_popup(popup_type,
	Rect2i(Vector2i(node.global_position), Vector2i(node.size)*ProjectSettings.get_setting("global/screen_scale")),  
	distribution_mode,
	item)

func _on_mouse_entered() -> void:
	print("mouse entered")
	_show_popup()
	

func _on_mouse_exited() -> void:
	PopupManager.hide_popup()
