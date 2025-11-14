extends PermanentAugment
class_name Augment2

@export var increment: float = 0.02

#Add 2% perma to the MPS
func _calculate_value() -> Big:
	var b_mps = Big.new(Stats.mod_mps)
	b_mps.multiplyEquals(increment)

	return b_mps

	
	
