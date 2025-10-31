extends Augment
class_name Augment2

@export var increment: float = 0.02

func augment_efect() -> void:
	Stats.add_percent_modifier(name,increment, tick_duration, Stats.MODIFIER_TYPE.MPS, permanent)


	
	
