extends PermanentAugment
class_name ManaPotion

@export var increment: float = 0.02

func _calculate_value() -> Big:
	var b_mps = Big.new(Stats.mod_mps)
	b_mps.multiplyEquals(increment)

	return b_mps

	
	
