extends BaseScene
class_name ClickScene


func _setup() -> void:
	_on_click_scene()


func _on_boss_scene() -> void:
	hide()

	
func _on_click_scene() -> void:
	show()
