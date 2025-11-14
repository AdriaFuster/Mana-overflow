extends Node2D

@onready var cauldron: CauldronAnimations = %TextureButton

func _ready() -> void:
	cauldron.pressed.connect(_on_pressed)
	

func _on_pressed() -> void:
	GameEvents.add_mana.emit(Stats.mod_cauldron_power)
	print("afegim ",Stats.mod_cauldron_power)
	GameEvents.cauldron_click.emit()
	cauldron.cauldron_click_anim()
