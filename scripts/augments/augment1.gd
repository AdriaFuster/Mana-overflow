extends Augment
class_name Augment1

@export var increment: float = 0.6
var _tick_counter: int = 0

func _init() -> void:
	GameEvents.cauldron_click.connect(_on_cauldron_click)
	
		
func tick() -> void:
	_tick_counter += 1
	if _tick_counter >= tick_rate:
		augment_efect()
		


func augment_efect() -> void:
	_tick_counter = 0
	Stats.add_percent_modifier(name,increment, tick_duration, Stats.MODIFIER_TYPE.MPS)
	

func _on_cauldron_click() -> void:
	_tick_counter = 0
	
	
