extends PermanentAugment
class_name ManaPotion

@export var increment: float

func _calculate_value() -> float:
	var b_mps = Stats.mod_mps
	b_mps *= increment

	return b_mps

	
	
