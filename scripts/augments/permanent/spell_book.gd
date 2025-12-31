extends PermanentAugment
class_name SpellBook

@export var mps_increment: float
@export var enhanced_mps_increment: float
@export var cp_increment: float
@export var enhanced_cp_increment: float


func setup_description() -> void:
	description_replacements["ARG1P"][0] = "mps_increment"
	description_replacements["ARG2P"][0] = "cp_increment"

func _calculate_value() -> float:
	var b_mps = Stats.mod_mps
	b_mps *= mps_increment
	
	return b_mps


func apply_effect() -> void:
	var add_mps_value: float = _calculate_value()
	set_tick_mps_increment(add_mps_value)
	Stats.mod_mps += add_mps_value
	Stats.mod_cauldron_power += cp_increment*Stats.mod_cauldron_power

func enhance() -> void:
	enhanced = true
	mps_increment = enhanced_mps_increment
	description_replacements["ARG1P"][1] = true
	super.enhance()	
	
