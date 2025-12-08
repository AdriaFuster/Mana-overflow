extends PermanentAugment
class_name ManaPotion

@export var increment: float

func setup_description() -> void:
	d_replacements["ARG1P"][0] = "increment"

func _calculate_value() -> float:
	var b_mps = Stats.mod_mps
	b_mps *= increment
	
	return b_mps

func enhance() -> void:
	enhanced = true
	increment = 0.35
	d_replacements["ARG1P"][1] = true
	super.enhance()	
	
