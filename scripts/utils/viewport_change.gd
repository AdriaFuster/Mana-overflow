@tool
extends Control
@onready var button_2: Button = $Control/Button2
@onready var button: Button = $Control/Button

#var main_scene := preload("uid://bmvh4dum13tdo")

func _ready() -> void:
	button.pressed.connect(_on_b1)
	button_2.pressed.connect(_on_b2)
	
func _on_b1() -> void:
	ProjectSettings.set_setting("display/window/size/viewport_width", 320)
	ProjectSettings.set_setting("display/window/size/viewport_height", 180)
	ProjectSettings.save()
	
	
	var scene_path = "res://scenes/main.tscn"
	var packed_scene : PackedScene = ResourceLoader.load(scene_path, "PackedScene")
	var scene_root = packed_scene.instantiate()
	var vp_container: SubViewportContainer = scene_root.get_node("CanvasLayer/SubViewportContainer")
	vp_container.stretch_shrink = 1
	var new_packed = PackedScene.new()
	new_packed.pack(scene_root)
	ResourceSaver.save(new_packed,scene_path)
	
	print("320x180")
	
func _on_b2() -> void:
	ProjectSettings.set_setting("display/window/size/viewport_width", 1280)
	ProjectSettings.set_setting("display/window/size/viewport_height", 720)
	ProjectSettings.save()
	
	
	var scene_path = "res://scenes/main.tscn"
	var packed_scene : PackedScene = ResourceLoader.load(scene_path, "PackedScene")
	var scene_root = packed_scene.instantiate()
	var vp_container: SubViewportContainer = scene_root.get_node("CanvasLayer/SubViewportContainer")
	print(vp_container)
	vp_container.stretch_shrink = 4
	var new_packed = PackedScene.new()
	new_packed.pack(scene_root)
	ResourceSaver.save(new_packed,scene_path)
	
	print("1280x720")
