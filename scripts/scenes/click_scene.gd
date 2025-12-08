extends Control
class_name ClickScene


func activate_scene() -> void:
	Inventory.reset_augments()
	show()


func desactivate_scene() -> void:
	Inventory.reset_augments()
	hide()
