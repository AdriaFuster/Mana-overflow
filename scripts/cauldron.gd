extends Node2D

@onready var cauldron: CauldronAnimations = %TextureButton

func _ready() -> void:
	cauldron.pressed.connect(_on_pressed)
	GameEvents.add_mana.connect(_on_add_mana)
	

func _on_pressed() -> void:
	GameEvents.add_mana.emit(Stats.cauldron_unit)
	

#Calls when button clicked but alsos when mps timer ends
func _on_add_mana(mana_points: int):
	cauldron.cauldron_click_anim()
