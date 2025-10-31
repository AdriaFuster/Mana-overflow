extends Control
class_name AugmentUI

@onready var icon: TextureRect = $UI/TextureRect

func set_icon(i: Texture2D) -> void:
	icon.texture = i

	
