extends PermanentAugment
class_name CeremonialHammer

@export var increment: float
@export var enhanced_increment: float

func setup_description() -> void:
	description_replacements["ARG1P"][0] = "increment"


func apply_effect() -> void:
	var cp_add_value: float = _calculate_value()
	Stats.mod_cauldron_power += cp_add_value
	set_tick_mps_increment(0)


func _calculate_value() -> float:
	var b_cp = Stats.cauldron_power
	b_cp *= increment
	
	return b_cp

func enhance() -> void:
	enhanced = true
	increment = 0.35
	description_replacements["ARG1P"][1] = true
	super.enhance()	
	
