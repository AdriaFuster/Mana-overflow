extends Control

@onready var list_container: VBoxContainer = $VBoxContainer
@export var ui_scene: PackedScene


func _ready() -> void:
	GameEvents.inventory_changed.connect(_on_inventory_changed)
	_on_inventory_changed()


func _on_inventory_changed() -> void:
	_queue_free_children()
	
	for i_name in Inventory.augments.keys():
		var aug: Augment = Inventory.augments[i_name]
		var aug_ui: AugmentUI = ui_scene.instantiate() as AugmentUI
		list_container.add_child(aug_ui)
		aug_ui.set_icon(aug.icon)
		

func _queue_free_children() -> void:
	for c in list_container.get_children():
		c.queue_free()	
