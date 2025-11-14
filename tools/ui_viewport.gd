@tool
class_name UIViewport
extends EditorScript

var window: Window

var gui := preload("uid://cdpmq485dco6l")

func _run() -> void:
	window = Window.new()
	EditorInterface.popup_dialog(window, Rect2i(Vector2(100, 100),Vector2(1280, 720)))
	
	var gui_scene := gui.instantiate()
	window.add_child(gui_scene)
	

	window.close_requested.connect(func(): window.queue_free())
	
