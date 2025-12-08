extends Node


func _ready() -> void:
	GameTick.tick.connect(_on_tick)


func _on_tick() -> void:
	#print("----------------------")
	ManaCalculator.reset_mod_values()
	
	ManaCalculator.calculate_cauldron_modifiers()
	
	Inventory._on_tick_tick_a()
	
	#Calculem MPS amb modifiers permanents
	ManaCalculator.calculate_augments()
	
	ManaCalculator.calculate_mana()
	
	#ManaCalculator.calculate_tick_modifiers()
	GameEvents.update_mps_label.emit()
