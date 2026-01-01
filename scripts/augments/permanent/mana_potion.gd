extends PermanentAugment
class_name ManaPotion

@export var increment: float
@export var enhanced_increment: float

func setup_description() -> void:
	description_replacements["ARG1P"][0] = "increment"

func _calculate_value() -> float:
	var b_mps = Stats.mod_mps
	b_mps *= increment
	
	return b_mps


func apply_effect() -> void:
	var add_mps_value: float = _calculate_value()
	set_tick_mps_increment(add_mps_value)
	Stats.mod_mps += add_mps_value

func enhance() -> void:
	enhanced = true
	increment = enhanced_increment
	description_replacements["ARG1P"][1] = true
	super.enhance()	
	
