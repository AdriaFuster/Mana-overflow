extends Node

func _ready() -> void:
	GameTick.tick.connect(_on_tick)


func _on_tick() -> void:
	ManaCalculator.reset_mod_values()
	
	ManaCalculator.calculate_cauldron_modifiers()
	
	Inventory._on_tick_permanent_a()
	
	GameEvents.update_mps_label.emit()
	
	#Calculem MPS amb modifiers permanents
	ManaCalculator.calculate_permanent_modifiers()
	
	Inventory._on_tick_tick_a()

	ManaCalculator.calculate_tick_modifiers()
		
		
