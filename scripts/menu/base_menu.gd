@abstract class_name BaseMenu extends Control

@onready var canvas_layer: CanvasLayer = %CanvasLayer
@onready var panel: PanelContainer = %Container
@onready var item_list: HBoxContainer = %ItemList
@onready var icon: TextureRect = %MenuIcon

@export var menu_icon: Texture2D

var slot_amount: int = 3

func _ready() -> void:
	icon.texture = menu_icon
	set_slots()
	
	
	
func show_menu() -> void:
	set_menu_size()
	
	set_items()
	
	show()
	canvas_layer.show()


func hide_menu() -> void:
	canvas_layer.hide()
	hide()

@abstract func set_menu_size()

@abstract func set_items()

@abstract func set_slots()
