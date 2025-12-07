extends PermanentAugment
class_name ManaPotion

@export var increment: float

func _calculate_value() -> float:
	var b_mps = Stats.mod_mps
	b_mps *= increment
	
	tick_mps_increment = b_mps
	return b_mps

func enhance() -> void:
	enhanced = true
	increment = 0.35
	d_replacements["INC_P"][1] = true
	super.enhance()	
	
