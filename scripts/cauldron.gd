extends Node2D

@onready var cauldron: CauldronAnimations = %TextureButton
@export var cauldron_unit: int = 1

func _ready() -> void:
	cauldron.pressed.connect(_on_pressed)
	

func _on_pressed() -> void:
	GameEvents.add_mana.emit(cauldron_unit)
	GameEvents.cauldron_click.emit()
	cauldron.cauldron_click_anim()
